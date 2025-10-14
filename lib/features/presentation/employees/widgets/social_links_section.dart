import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SocialLinksSection extends StatelessWidget {
  const SocialLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialIcon(Icons.facebook, AppColors.primary),
        _buildSocialIcon(Icons.flutter_dash, AppColors.info),
        _buildSocialIcon(Icons.business, AppColors.secondary),
        _buildSocialIcon(Icons.camera_alt, AppColors.primaryRed),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: AppColors.background,
        size: 20,
      ),
    );
  }
}
