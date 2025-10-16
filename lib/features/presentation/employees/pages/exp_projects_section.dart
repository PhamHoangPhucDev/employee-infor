import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../../core/components/app_dialog_component.dart.dart';
import '../../../../core/components/button/circle_icon_button.dart';
import '../../../../core/components/button/confirm_bottom_sheet.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../widgets/project_Card.dart';

class ExpProjectsSection extends StatelessWidget {
  const ExpProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    
    final events = [
      EventItem(
        time: '01/2025 - 06/2025',
        title: 'Design Leader',
        company: 'Công ty TNHH Hoa Sen',
        location: 'Ho Chi Minh - Viet Nam',
        yearExp: '6 tháng',
      ),
      EventItem(
        time: '06/2023 - 12/2025',
        title: 'Nanager Dev',
        company: 'Công ty quốc tế ngoại cảnh TP.HCM',
        location: 'Korean',
        yearExp: '1 năm 6 tháng',
      ),
      EventItem(
        time: '03/2022 - 06/2023',
        title: 'Nanager Dev',
        company: 'Công ty quốc tế ngoại cảnh TP.HCM',
        location: 'Korean',
        yearExp: '3 tháng',
      ),
      EventItem(
        time: '03/2022 - 06/2023',
        title: 'Nanager Dev',
        company: 'Công ty quốc tế ngoại cảnh TP.HCM',
        location: 'Korean',
        yearExp: '3 tháng',
      ),
      EventItem(
        time: '03/2022 - 06/2023',
        title: 'Nanager Dev',
        company: 'Công ty quốc tế ngoại cảnh TP.HCM',
        location: 'Korean',
        yearExp: '3 tháng',
      ),
      EventItem(
        time: '03/2022 - 06/2023',
        title: 'Nanager Dev',
        company: 'Công ty quốc tế ngoại cảnh TP.HCM',
        location: 'Korean',
        yearExp: '6 tháng',
      )
    ];


    return Timeline.tileBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      theme: TimelineThemeData(
        nodePosition: 0, // Đặt về 0 để căn trái
        connectorTheme: const ConnectorThemeData(thickness: 2.5),
      ),
      builder: TimelineTileBuilder.connected(
        itemCount: events.length,
        indicatorBuilder: (context, index) =>
          OutlinedDotIndicator(color: AppColors.primary, size: 13.sp,borderWidth: 2,),
        connectorBuilder: (_, index, ___) =>
          SolidLineConnector(color: AppColors.backgroundInput),
        contentsBuilder: (context, index) {
          final e = events[index];
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${e.time} | ${e.yearExp}" ,
                      style: AppTypography.smallbody(color: AppColors.primary),
                    ),
                    Row(
                      children: [
                        CircleIconButton(
                          iconSize: 15,
                          icon: HugeIcons.strokeRoundedPencilEdit02,
                          backgroundColor: AppColors.info,
                          iconColor: AppColors.background,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 4,),
                ProjectCard(
                  company: e.company,
                  location: e.location,
                  title: e.title,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class EventItem {
  final String time;
  final String title;
  final String company;
  final String location;
  final String yearExp;

  EventItem({
    required this.time,
    required this.title,
    required this.company,
    required this.location,
    required this.yearExp,
  });
}