import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/theme/app_colors.dart';

class ExperienceListSection extends StatelessWidget {
  const ExperienceListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildExperienceCard('🔍', 'Google', 'UI/UX Designer', '3 years', true),
          const SizedBox(height: 12),
          _buildExperienceCard('🏠', 'Airbnb', 'UI Intern', '6 months', false),
          const SizedBox(height: 12),
          _buildExperienceCard('🍕', 'Zomato', 'Product Designer', '1 year', false),
          const SizedBox(height: 24),
           SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(
      String logo, String company, String role, String duration, bool highlight) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: highlight ? AppColors.primary : Colors.grey.shade200,
          width: highlight ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: .03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(logo, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(company,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(role,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600)),
                    Text(' - ',
                        style: TextStyle(color: Colors.grey.shade400)),
                    Text(duration,
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey.shade600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
