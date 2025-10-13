import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/button/text_button_component.dart';
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
        Row(
          children: [
            TextButtonComponent(
              title: title,
              color: title == "Hôm nay"?AppColors.primary:AppColors.background,
            ),
            if(title == "Hôm nay")...[
              SizedBox(width: 10,),
              SizedBox(
                width: 40.w,
                height: 5.h,
                child: TextField(
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
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              
              Expanded(
                child: Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: Text("Tất cả",style: AppTypography.smallbody(color: AppColors.primary,decoration: TextDecoration.underline),)
                )
              ),
            ]
          ],
        ),
        Divider(color: AppColors.backgroundInput,),
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