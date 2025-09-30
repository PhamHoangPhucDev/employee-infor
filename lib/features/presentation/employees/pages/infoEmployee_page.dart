import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/app_appBar.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class InfoEmployeePage extends StatelessWidget {
  const InfoEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.infoEmployeeTitle,),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //Avatar
              Container(
                height: 15.h,
                width: 100.w,
                color: AppColors.primary,
                child: Center(
                  child: SizedBox(
                    width: 70.w,
                    height: 15.h,
                    child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: AppColors.background,
                      // backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
                      child: Icon(Icons.person,)
                    ),
                    title: Text("Nguyễn Văn A",style: AppTypography.body(color: AppColors.textLight),),
                    subtitle: Text("Nhân viên",style: AppTypography.smallbody(color: AppColors.textLight),),
                    ),
                  ),
                )
              ),

              //Trọng tâm
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5.h, 10, 2.h),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundInput, // nền
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Trọng tâm: ",
                          style: AppTypography.body(),
                        ),
                        TextSpan(
                          text: "Tác động của sự mất cân bằng nội tiết tố lên tình trạng da, chuyên về mụn trứng cá, chứng rậm lông và các rối loạn da khác. ",
                          style: AppTypography.smallbody(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Divider(color: AppColors.backgroundInput, indent: 10,endIndent: 10,),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text("Hồ sơ",style: AppTypography.body(color: AppColors.primary),),
              ),
              Divider(color: AppColors.backgroundInput, indent: 10,endIndent: 10,),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                child: Text(
                  "Với mục tiêu tối thiểu là có thể thực hiện được, điều này sẽ không xảy ra khi bạn phải làm việc quá sức để có được giải pháp sau mỗi giao dịch.",
                  style: AppTypography.smallbody(),
                ),
              ),

              Divider(color: AppColors.backgroundInput, indent: 10,endIndent: 10,),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text("Sự nghiệp",style: AppTypography.body(color: AppColors.primary),),
              ),
              Divider(color: AppColors.backgroundInput, indent: 10,endIndent: 10,),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                child: Text(
                  "Với mục tiêu tối thiểu là có thể thực hiện được, điều này sẽ không xảy ra khi bạn phải làm việc quá sức để có được giải pháp sau mỗi giao dịch.",
                  style: AppTypography.smallbody(),
                ),
              ),

              Divider(color: AppColors.backgroundInput, indent: 10,endIndent: 10,),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text("Nổi bật",style: AppTypography.body(color: AppColors.primary),),
              ),
              Divider(color: AppColors.backgroundInput, indent: 10,endIndent: 10,),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
                child: Text(
                  "Với mục tiêu tối thiểu là có thể thực hiện được, điều này sẽ không xảy ra khi bạn phải làm việc quá sức để có được giải pháp sau mỗi giao dịch.",
                  style: AppTypography.smallbody(),
                ),
              ),
            ],
          ),

          //Kinh nghiệm & thời gian đi làm
          Positioned(
            top: 12.5.h,
            child: SizedBox(
              width: 100.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 5.h,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.background, // nền
                      border: Border.all(
                        color: AppColors.primary, // màu border
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // chỉ vừa với nội dung
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HugeIcon(icon: HugeIcons.strokeRoundedMedal06,color: AppColors.primary,size: 22.sp),
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("15 năm",style: AppTypography.smallbody()),
                            Text("kinh nghiệm",style: AppTypography.smallbody()),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 5.h,
                    width: 65.w,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.background, // nền
                      border: Border.all(
                        color: AppColors.primary, // màu border
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // chỉ vừa với nội dung
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        HugeIcon(icon: HugeIcons.strokeRoundedAlarmClock,color: AppColors.primary,size: 18.sp),
                        SizedBox(width: 5,),
                        Text(
                          "Mon-Sat / 9:00AM - 5:00PM", style: AppTypography.body(),
                        ),
                      ],
                    ),
                  ),
              
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}