import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/components/section_header_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../data/models/functionItem_model.dart';
import 'icon_text_button.dart';

class FunctionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final List<FunctionItem> functionItems;
  final double minExtentHeight;
  final double maxExtentHeight;

  FunctionHeaderDelegate({
    required this.functionItems,
    this.minExtentHeight = 13,
    this.maxExtentHeight = 13.5,
  });

  @override
  double get minExtent => minExtentHeight.h;
  @override
  double get maxExtent => maxExtentHeight.h;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // Tính tỉ lệ cuộn 0 → 1
    final progress = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    // Hiệu ứng mờ dần
    final opacity = 1 - progress * 1.5;
    // Hiệu ứng trượt lên (dịch chuyển theo trục Y)
    final offsetY = -10 * progress; // trượt lên 10px khi cuộn đầy đủ

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(
              offset: Offset(0, offsetY),
              child: Opacity(
                opacity: opacity.clamp(0.0, 1.0),
                child: SectionHeaderComponent(title: "Danh sách chức năng"),
              ),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: functionItems.length,
                itemBuilder: (context, index) {
                  final item = functionItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 20.w,
                      child: IconTextButton(
                        icon: item.icon,
                        label: item.label,
                        onPressed: item.onPressed,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(FunctionHeaderDelegate oldDelegate) => true;
}
