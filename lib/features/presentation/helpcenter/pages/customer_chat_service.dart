import 'dart:convert';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/components/appBar_component.dart';
import '../../../../core/components/button/circle_icon_button.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CustomerChatServicePage extends StatefulWidget {
  const CustomerChatServicePage({super.key});

  @override
  State<CustomerChatServicePage> createState() => _CustomerChatServicePageState();
}

class _CustomerChatServicePageState extends State<CustomerChatServicePage> {
  final ChatUser user = ChatUser(id: 'user', firstName: 'You');
  final ChatUser ai = ChatUser(id: 'ai', firstName: 'AI');
  final List<ChatMessage> messages = [];
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<bool> _hasTextNotifier = ValueNotifier(false);

  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _hasTextNotifier.value = _controller.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _hasTextNotifier.dispose();
    super.dispose();
  }

  Future<void> sendMessage(ChatMessage m) async {
    setState(() {
      messages.insert(0, m); // chèn tin nhắn lên đầu list tin nhắn
      _isTyping = true; // hiển thị trạng thái AI đang trả lời
    });

    final reply = await getAIReply(m.text);

    //AI rep tin nhắn
    final msg = ChatMessage(
      user: ai,
      createdAt: DateTime.now(),
      text: reply,
    );

    setState(() {
      messages.insert(0, msg);
      _isTyping = false;
    });
  }

  //connect API 
  Future<String> getAIReply(String prompt) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      return 'Lỗi: OPENAI_API_KEY chưa được cấu hình.';
    }

    Future<http.Response> callApi() {
      return http
          .post(
            Uri.parse('https://api.openai.com/v1/chat/completions'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $apiKey',
            },
            body: jsonEncode({
              "model": "gpt-3.5-turbo",
              "messages": [
                {"role": "system", "content": "Bạn là trợ lý AI thông minh, thân thiện."},
                {"role": "user", "content": prompt}
              ]
            }),
          )
          .timeout(const Duration(seconds: 10));
    }

    http.Response? response;
    int attempts = 0;

    while (attempts < 2) { // retry 1 lần
      attempts++;
      try {
        response = await callApi();
        break; // success
      } catch (e) {
        if (attempts >= 2) {
          return 'Lỗi kết nối hoặc timeout: $e';
        }
      }
    }

    if (response == null) {
      return 'Lỗi không xác định: Response null';
    }

    dynamic data;
    try {
      data = jsonDecode(response.body);
    } catch (e) {
      return 'Lỗi parse JSON: $e';
    }

    if (data['error'] != null) {
      final errorMsg = data['error']['message'] ?? 'Lỗi khi gọi API OpenAI';
      return 'Xin lỗi, $errorMsg';
    }

    if (data['choices'] != null &&
        data['choices'] is List &&
        data['choices'].isNotEmpty) {
      final message = data['choices'][0]['message']?['content'];
      return message ?? 'Xin lỗi, tôi chưa hiểu câu hỏi.';
    }

    return 'Xin lỗi, OpenAI không trả kết quả hợp lệ.';
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.chatboxTitle),
      body: Container(
        color: AppColors.background, // nền chat
        child: DashChat(
          currentUser: user,
          typingUsers: _isTyping ? [ai] : [],
          messages: messages,
          onSend: (msg) {
            if (msg.text.trim().isEmpty) return;
            sendMessage(msg);
            _controller.clear();
          },
          //input nhập text
          inputOptions: InputOptions(
            textController: _controller,
            focusNode: _focusNode,
            inputTextStyle: AppTypography.body(),
            inputDecoration: InputDecoration(
              hintText: "Nhập tin nhắn...",
              filled: true,
              fillColor: AppColors.backgroundInput,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
            //nút gửi
            sendButtonBuilder: (Function() send) {
              return ValueListenableBuilder<bool>(
              valueListenable: _hasTextNotifier,
              builder: (context, hasText, child) {
                if (hasText) {
                  return Container(
                    margin: EdgeInsets.only(left: 10),
                    child: CircleIconButton(
                    icon: HugeIcons.strokeRoundedSent,
                      backgroundColor: AppColors.primary,
                      iconColor: AppColors.background,
                      iconSize: 23,
                      onPressed: send,
                    ),
                  );
                } else {
                  return SizedBox();
                }
              });
            },
            //icon chức năng chụp/album/file
             leading: [
              ValueListenableBuilder<bool>(
                valueListenable: _hasTextNotifier,
                builder: (context, hasText, child) {
                  if (hasText) {
                    return GestureDetector(
                      onTap: (){
                        _hasTextNotifier.value = false;
                        _focusNode.requestFocus(); // giữ keyboard
                      },
                      child: HugeIcon(icon: HugeIcons.strokeRoundedArrowRight01),
                    );
                  } else {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleIconButton(
                          onPressed: pickImageFromCamera,
                          icon: HugeIcons.strokeRoundedCamera01,
                          iconSize: 20,
                        ),
                        CircleIconButton(
                          onPressed: pickImageFromGallery,
                          icon: HugeIcons.strokeRoundedAlbum02,
                          iconSize: 20,
                        ),
                        CircleIconButton(
                          onPressed: pickFile,
                          icon: HugeIcons.strokeRoundedFileAttachment,
                          iconSize: 20,
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
          messageOptions: MessageOptions(
            showOtherUsersAvatar: true,   // hiển thị avatar người khác
            messagePadding: const EdgeInsets.all(8), // padding tin nhắn
            // avatar design
            avatarBuilder: (ChatUser user, Function? onTap, Function? onLongPress) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.primary,
                  child: Text(user.firstName ?? "?"),
                ),
              );
            },
            // messenger design
            messageDecorationBuilder: (ChatMessage msg, ChatMessage? previousMessage, ChatMessage? nextMessage) {
              final isMe = msg.user.id == user.id; // xác định là user hay AI
              return BoxDecoration(
                color: isMe ? AppColors.primary : AppColors.disabled,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isMe ? 20 : 0),
                  bottomRight: Radius.circular(isMe ? 0 : 20),
                ),
              );
            },
          ),

          //Tin nhắn mới auto kéo xuống đáy
          // scrollToBottomOptions: ScrollToBottomOptions(
          //   scrollToBottomBuilder: (ScrollController controller) {
          //     return GestureDetector(
          //       onTap: () {
          //         // Scroll về cuối
          //         controller.animateTo(
          //           controller.position.maxScrollExtent,
          //           duration: const Duration(milliseconds: 300),
          //           curve: Curves.easeOut,
          //         );
          //       },
          //       child: Container(
          //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //         margin: const EdgeInsets.all(8),
          //         decoration: BoxDecoration(
          //           color: Colors.blue,
          //           borderRadius: BorderRadius.circular(20),
          //         ),
          //         child: const Text(
          //           "Xem tin nhắn mới",
          //           style: TextStyle(color: Colors.white),
          //         ),
          //       ),
          //     );
          //   },
          //   onScrollToBottomPress: null,
          // ),
        ),
      ),
    );
  }

  void pickImageFromGallery() {
  }

  void pickImageFromCamera() {
  }

  void pickFile() {
  }
}