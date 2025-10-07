import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class SearchBarHeaderComponent extends StatelessWidget {
  final double maxH;
  final double minH;
  final TextEditingController? controller;

  const SearchBarHeaderComponent({
    super.key,
    this.maxH = 10,
    this.minH = 8,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true, // giữ search dính trên khi cuộn
      delegate: SearchBarDelegate(
        maxH: maxH,
        minH: minH,
        controller: controller,
      ),
    );
  }
}

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  final double maxH;
  final double minH;
  final TextEditingController? controller;

  SearchBarDelegate({required this.maxH, required this.minH, this.controller});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.primary,
      child: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
          child: Align(
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
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
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxH.h;

  @override
  double get minExtent => minH.h;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}
