import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/appBar_component.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class InfoEmployeePage extends StatelessWidget {
  const InfoEmployeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.infoEmployeeTitle),
      body: CustomScrollView(
        slivers: [
          /// Avatar + overlay
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                /// Avatar & info
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
                          child: const Icon(Icons.person),
                        ),
                        title: Text("Nguyễn Văn A",
                            style: AppTypography.body(color: AppColors.textLight)),
                        subtitle: Text("Nhân viên",
                            style: AppTypography.smallbody(color: AppColors.textLight)),
                      ),
                    ),
                  ),
                ),

                /// Overlay box (Positioned)
                Positioned(
                  bottom: -2.5.h,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      children: [
                        Container(
                          height: 5.h,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            border: Border.all(color: AppColors.primary, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedMedal06,
                                color: AppColors.primary,
                                size: 22.sp,
                              ),
                              SizedBox(width: 1.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("15 năm", style: AppTypography.smallbody()),
                                  Text("kinh nghiệm", style: AppTypography.smallbody()),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 5.h,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              border: Border.all(color: AppColors.primary, width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedAlarmClock,
                                  color: AppColors.primary,
                                  size: 18.sp,
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Text("Mon-Sat / 9:00AM - 5:00PM",
                                      style: AppTypography.body(),overflow: TextOverflow.ellipsis,maxLines: 1,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Trọng tâm
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 7.h, 10, 2.h), // chừa khoảng trống cho overlay
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.backgroundInput,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: "Trọng tâm: ", style: AppTypography.body()),
                      TextSpan(
                        text:
                            "Tác động của sự mất cân bằng nội tiết tố lên tình trạng da, chuyên về mụn trứng cá, chứng rậm lông và các rối loạn da khác.",
                        style: AppTypography.smallbody(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// Hồ sơ
          _buildSection("Hồ sơ",
              "Với mục tiêu tối thiểu là có thể thực hiện được, điều này sẽ không xảy ra khi bạn phải làm việc quá sức để có được giải pháp sau mỗi giao dịch."),

          /// Sự nghiệp
          _buildSection("Sự nghiệp",
              "Với mục tiêu tối thiểu là có thể thực hiện được, điều này sẽ không xảy ra khi bạn phải làm việc quá sức để có được giải pháp sau mỗi giao dịch."),

          /// Nổi bật
          _buildSection("Nổi bật",
              "Với mục tiêu tối thiểu là có thể thực hiện được, điều này sẽ không xảy ra khi bạn phải làm việc quá sức để có được giải pháp sau mỗi giao dịch."),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSection(String title, String content) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: AppColors.backgroundInput, indent: 10, endIndent: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child:
                Text(title, style: AppTypography.body(color: AppColors.primary)),
          ),
          Divider(color: AppColors.backgroundInput, indent: 10, endIndent: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(content, style: AppTypography.smallbody()),
          ),
        ],
      ),
    );
  }
}
