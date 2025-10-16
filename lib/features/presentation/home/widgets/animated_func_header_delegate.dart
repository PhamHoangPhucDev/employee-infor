import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/button/circle_icon_button.dart';
import '../../../../core/components/button/confirm_bottom_sheet.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AnimatedFunctionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _maxExtentHeight = 11.h; // chiều cao tối đa
  final double _minExtentHeight = 0;    // khi cuộn hết thì ẩn

  @override
  double get minExtent => _minExtentHeight;

  @override
  double get maxExtent => _maxExtentHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    final opacity = 1 - progress;
    final scale = 1 - (progress * 0.2); // thu nhỏ tối đa 20%

    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // nền chính
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
          ),

          // nội dung header
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.scale(
              scale: scale,
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: opacity,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                    bottom: 10,
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.background,
                            child: const FlutterLogo(),
                          ),
                          const SizedBox(width: 8),
                          FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Xin chào", style: AppTypography.smallbody(color: AppColors.background)),
                                Text("Bạn", style: AppTypography.body(color: AppColors.background)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CircleIconButton(
                        icon: HugeIcons.strokeRoundedLogout02,
                        iconSize: 20,
                        sizeCircle: 30,
                        iconColor: AppColors.primary,
                        onPressed: () => showConfirmBottomSheet(
                          title: "Bạn có chắc chắn muốn đăng xuất không?",
                          confirmText: "Xác nhận",
                          onConfirm: () {
                            debugPrint("Đăng xuất thành công");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant AnimatedFunctionHeaderDelegate oldDelegate) => true;
}
