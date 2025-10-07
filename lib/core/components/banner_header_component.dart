import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class BannerHeaderComponent extends StatelessWidget {
  final String text;
  final Color backgroundColor;

  const BannerHeaderComponent({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: false,
      floating: false,
      delegate: BannerDelegate(
        text: text,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class BannerDelegate extends SliverPersistentHeaderDelegate {
  final String text;
  final Color backgroundColor;

  BannerDelegate({
    required this.text,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // shrinkOffset chạy từ 0 -> maxExtent - minExtent
    double percent = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);

    // Thêm easing (cubic) để ẩn mượt hơn
    double smoothOpacity = Curves.easeOut.transform(1 - percent);

    return Container(
      color: backgroundColor,
      alignment: Alignment.center,
      child: Opacity(
        opacity: smoothOpacity, // càng scroll càng mờ
        child: Text(
          text,
          style: AppTypography.smallbody(color: AppColors.textLight),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 3.h; // chiều cao ban đầu (dùng Sizer)
  @override
  double get minExtent => 0;    // khi scroll hết thì ẩn
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;
}