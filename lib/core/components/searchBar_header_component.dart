import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'button/circle_icon_button.dart';

class SearchBarHeaderComponent extends StatelessWidget {
  final double maxH;
  final double minH;
  final TextEditingController? controller;
  final String? title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final Color? backgroundColor;
  final bool? showSearchInput;

  const SearchBarHeaderComponent({
    super.key,
    this.maxH = 10,
    this.minH = 9,
    this.controller,
    this.title,
    this.onActionTap,
    this.actionText,
    this.backgroundColor = AppColors.primary,
    this.showSearchInput = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true, // giữ search dính trên khi cuộn
      delegate: SearchBarDelegate(
        maxH: maxH,
        minH: minH,
        controller: controller,
        title: title,
        actionText: actionText,
        backgroundColor: backgroundColor,
        showSearchInput: showSearchInput,
        onActionTap: onActionTap,
      ),
    );
  }
}

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final double maxH;
  final double minH;
  final TextEditingController? controller;
  final String? title;
  final String? actionText;
  final VoidCallback? onActionTap;
  final Color? backgroundColor;
  final bool? showSearchInput;

  SearchBarDelegate({this.showSearchInput,this.title, this.actionText, this.onActionTap, this.backgroundColor,required this.maxH, required this.minH, this.controller});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showSearchInput!)
          TextField(
            controller: TextEditingController(),
            style: AppTypography.button(color: AppColors.primary),
            decoration: InputDecoration(
              hintText: "Tìm kiếm...",
              hintStyle: AppTypography.body(color: AppColors.primary),
              filled: true,
              fillColor: AppColors.background,
              prefixIcon: Icon(Icons.search, color: AppColors.primary),
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: AppColors.background, width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: AppColors.background, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: AppColors.background, width: 3),
              ),
            ),
          ),
          if (title != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$title",style: AppTypography.subtitle()),
              actionText != null 
                ? GestureDetector(
                  onTap: onActionTap,
                  child: Text(actionText!, style: AppTypography.smallbody(color: AppColors.primary,decoration: TextDecoration.underline)))
                : CircleIconButton(
                  icon: HugeIcons.strokeRoundedFilter,
                  backgroundColor: AppColors.primary,
                  iconColor: AppColors.background,
                  sizeCircle: 30,
                  onPressed: onActionTap,
                ),
              
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxH.h - (showSearchInput == false? 7.h : 0) + (title != null ? 4.h : 0);

  @override
  double get minExtent => minH.h - (showSearchInput == false ? 6.h : 0) + (title != null ? 4.h : 0);

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
