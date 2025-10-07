import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../data/models/prCode_model.dart';

class ExpansionPanelListRadio extends StatefulWidget {
  ExpansionPanelListRadio({super.key,required this.items,required this.tabIndex});
  List<PrCodeModel> items;
  int tabIndex;
  @override
  State<ExpansionPanelListRadio> createState() => _ExpansionPanelListRadioState();
}

class _ExpansionPanelListRadioState extends State<ExpansionPanelListRadio> {

  //Lưu expandedIndex cho mỗi tab
  Map<int, int> expandedIndexMap = {};
  
  @override
  void initState() {
    //Tự động tạo Map dựa trên số lượng tabs
    for (int i = 0; i < widget.items.length; i++) {
      expandedIndexMap[i] = 0; // Mở item đầu tiên mỗi tab
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        final isExpanded = expandedIndexMap[widget.tabIndex] == index;
        
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: expandedIndexMap[widget.tabIndex] == index ? AppColors.primary : AppColors.background,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: expandedIndexMap[widget.tabIndex] == index ? AppColors.background : AppColors.buttonLight)
              ),
              padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    // đóng cái cũ, mở cái mới
                    if (expandedIndexMap[widget.tabIndex] != index) {
                      expandedIndexMap[widget.tabIndex] = index;
                    } else {
                      expandedIndexMap[widget.tabIndex] = -1; // Cho phép đóng
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.name??"",
                        style: AppTypography.button(
                          fW: expandedIndexMap[widget.tabIndex] == index ? FontWeight.bold : FontWeight.w500,
                          color: expandedIndexMap[widget.tabIndex] == index ? AppColors.textLight : AppColors.primary
                        ),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0, // Xoay 180 độ
                        duration: Duration(milliseconds: 400),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedArrowDown01,
                          color: expandedIndexMap[widget.tabIndex] == index ? AppColors.textLight : AppColors.primary,
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              child: isExpanded
                  ? Container(
                      width: 100.w,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(item.subname??"",style: AppTypography.smallbody(),),
                    )
                  : SizedBox.shrink(),
            ),
            SizedBox(height: 10,)
          ],
        );
      },
    );
  }
}