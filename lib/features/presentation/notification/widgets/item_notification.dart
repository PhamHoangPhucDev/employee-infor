import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/button/text_button_component.dart';
import '../../../../core/components/section_header_component.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ItemNotification extends StatelessWidget {
  ItemNotification({super.key,required this.title,required this.listNotification});
  String title;
  List<Map<String,dynamic>> listNotification;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: SectionHeaderComponent(
            title: title,
            trading: Row(
              mainAxisSize: MainAxisSize.min, // 👈 Quan trọng để Row co theo nội dung
              children: [
                if (title == "Hôm nay") ...[
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "Tất cả",
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.smallbody(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: listNotification.length,
          itemBuilder: (context, index) {
            final item = listNotification[index];
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: AppColors.background, // màu nền
                foregroundColor: AppColors.primary, // màu chữ
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // bo góc
                ),
                elevation: 0, // bỏ shadow
                shadowColor: Colors.transparent,// bỏ màu shadow khi nhấn
              ),
              onPressed: (){},
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary,
                  ),
                  child: HugeIcon(icon: HugeIcons.strokeRoundedCalendar03,color: AppColors.textLight,size: 20.sp,),
                ),
                title: Text(item["title"] as String,style: AppTypography.body(),overflow: TextOverflow.ellipsis,),
                subtitle: Text(item["subtitle"] as String,style: AppTypography.base,maxLines: 2,overflow: TextOverflow.ellipsis,),
                trailing: Text(item["time"] as String,style: AppTypography.smallbody(),),
              ),
            );
          },
        ),
        Divider(color: AppColors.backgroundInput,),
      ],
    );
  }
}