import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../core/components/appBar_component.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import 'employees_controller.dart';
import 'widgets/header_section.dart';
import 'widgets/profile_info_section.dart';
import 'widgets/social_links_section.dart';
import 'widgets/follow_stats_section.dart';
import 'widgets/tabs_section.dart';
import 'widgets/experience_list_section.dart';

class EmployeesPage extends StatelessWidget {
  final controller = Get.put(EmployeesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          controller.updateScroll(scroll.metrics.pixels);
          return false;
        },
        child: CustomScrollView(
          slivers: [
            // HEADER (ẩn dần khi cuộn)
            SliverAppBar(
              backgroundColor: AppColors.background,
              pinned: false,
              expandedHeight: 36.h,
              automaticallyImplyLeading: true,//nút Back
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  double percent = (constraints.maxHeight - kToolbarHeight) / (32.h - kToolbarHeight);
                  percent = percent.clamp(0.0, 1.0);
                  return FlexibleSpaceBar(
                    background: Opacity(
                      opacity: percent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          HeaderSection(),
                          ProfileInfoSection(),
                          SocialLinksSection(),
                          FollowStatsSection(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // ===== STICKY TABS
            SliverPersistentHeader(
              pinned: true,
              delegate: TabsHeaderDelegate(),
            ),

            // ===== CONTENT
            SliverToBoxAdapter(
              child: ExperienceListSection(),
            ),
          ],
        ),
      ),
    );
  }
}
