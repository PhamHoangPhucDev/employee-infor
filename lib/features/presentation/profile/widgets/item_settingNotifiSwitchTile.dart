import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ItemSettingNotifiSwitchTile extends StatelessWidget {
  ItemSettingNotifiSwitchTile({  Key? key,required this.title,required this.value,required this.onChanged,});
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: AppTypography.button(color: AppColors.text),
      ),
      trailing: Transform.scale(
        scaleX: 0.9, // width switch
        scaleY: 0.85,//height switch
        child: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: AppColors.background, // màu của nút tròn khi bật
          activeTrackColor: AppColors.primary,    // màu nền đường khi bật
          inactiveThumbColor: AppColors.background, // màu của nút tròn khi tắt
          inactiveTrackColor: AppColors.buttonLight, // màu nền đường khi tắt
        ),
      ),
      onTap: () => onChanged(!value), // bấm cả dòng cũng toggle
    );
  }
}