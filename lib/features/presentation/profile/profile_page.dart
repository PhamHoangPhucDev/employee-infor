import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/auth_controller.dart';
import 'profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Họ tên: ${ctrl.name}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Email: ${ctrl.email}', style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Center(child: ElevatedButton(onPressed: () => Get.find<AuthController>().logout(), child: const Text('Đăng xuất'))),
          ],
        ),
      ),
    );
  }
}
