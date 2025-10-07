import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/button/listTile_icon_button.dart';
import 'customer_chat_service.dart';

class ContactUsPage extends StatelessWidget {
  ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final items = [
      {
        "title": "Dịch vụ khách hàng",
        "icon": HugeIcons.strokeRoundedCustomerService01,
        "func": ()=> Get.to(()=> CustomerChatServicePage()),
      },
      {
        "title": "Website",
        "icon": HugeIcons.strokeRoundedInternet,
        "func": (){},
      },
      {
        "title": "Whatsapp",
        "icon": HugeIcons.strokeRoundedWhatsapp,
        "func": () async {
           showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text('Mã QR của bạn'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 60.w,
                        width: 60.w,
                        child: QrImageView(
                          data: 'https://flutter.dev', // dữ liệu QR
                          version: QrVersions.auto,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text('Quét mã này để mở liên kết.'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Đóng'),
                    ),
                  ],
                );
              },
            );
        }
      },
      {
        "title": "Facebook",
        "icon": HugeIcons.strokeRoundedFacebook01,
        "func": (){},
      },
      {
        "title": "Instagram",
        "icon": HugeIcons.strokeRoundedInstagram,
        "func": () {}
      },
    ];

    return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = items[index];
                  return ListTileIconButtonComponent(
                    title: item["title"] as String,
                    icon: item["icon"] as List<List<dynamic>>,
                    func: item["func"] as VoidCallback,
                  );
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      );
  }
}