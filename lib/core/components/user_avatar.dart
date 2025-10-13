import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String seed;
  final double size;

  const UserAvatar({super.key, required this.seed, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.grey[200],
      backgroundImage: NetworkImage(
        "https://upload.wikimedia.org/wikipedia/commons/1/17/Google-flutter-logo.png",
      ),
      onBackgroundImageError: (_, __) {
        debugPrint("Lỗi tải avatar seed: $seed");
      },
    );
  }
}
