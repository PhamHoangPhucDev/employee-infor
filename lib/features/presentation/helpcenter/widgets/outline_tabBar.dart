import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class OutlineTabBar extends StatefulWidget {
  final TabController controller;
  final List<String> tabs;
  final Color selectedColor;
  final Color unselectedColor;
  final EdgeInsets padding;


  OutlineTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
    this.selectedColor = AppColors.primary,
    this.unselectedColor = AppColors.background,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
  }) : super(key: key);

  @override
  State<OutlineTabBar> createState() => _OutlineTabBarState();
}

class _OutlineTabBarState extends State<OutlineTabBar> {

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.indexIsChanging) {
        setState(() {});
      }
    });
  }

@override
Widget build(BuildContext context) {
  return TabBar(
    controller: widget.controller,
    indicator: BoxDecoration(), // bỏ indicator mặc định
    labelPadding: EdgeInsets.zero,
    indicatorColor: Colors.transparent,
    dividerColor: Colors.transparent,
    tabs: widget.tabs.map((title) {
      final isSelected = widget.tabs.indexOf(title) == widget.controller.index;

      return Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: isSelected ? widget.selectedColor : widget.unselectedColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isSelected ? widget.unselectedColor : widget.selectedColor),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.button(
            color: isSelected ? AppColors.textLight : AppColors.text,
            fW: isSelected ? FontWeight.w400 : FontWeight.bold,
          )
        ),
      );
    }).toList(),
  );
}


}
