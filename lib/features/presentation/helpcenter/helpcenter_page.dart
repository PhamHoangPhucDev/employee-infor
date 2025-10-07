import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/appBar_component.dart';
import '../../../core/components/searchBar_header_component.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/components/banner_header_component.dart';
import 'pages/contact_us.dart';
import 'pages/faq.dart';
import 'widgets/outline_tabBar.dart';
import 'widgets/sliver_appBar_delegate.dart';

class HelpcenterPage extends StatefulWidget {
  const HelpcenterPage({super.key});

  @override
  State<HelpcenterPage> createState() => _HelpcenterPageState();
}

class _HelpcenterPageState extends State<HelpcenterPage>  with TickerProviderStateMixin {

  late TabController mainTabController;
  List<String> listTab = ["Câu Hỏi Thường Gặp","Liên Hệ Với Chúng Tôi"];

  @override
  void initState() {
    super.initState();
    mainTabController = TabController(length: listTab.length, vsync: this);
  }

  @override
  void dispose() {
    mainTabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarComponent(title: AppStrings.helpcenterTitle),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // Banner ẩn dần
            BannerHeaderComponent(text: "Chúng Tôi Có Thể Giúp Được Gì Cho Bạn?",),
            // Search
            SearchBarHeaderComponent(),

            SliverToBoxAdapter(child: SizedBox(height: 10)),
            //TabBarView
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                child:  
                PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: OutlineTabBar(
                    controller: mainTabController,
                    tabs: listTab,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  ),
                ),
              ),
            ),
            
          ],
          body: TabBarView(
            controller: mainTabController,
            physics: NeverScrollableScrollPhysics(),// không cho vuốt ngang
            children: [
              FAQPage(),
              ContactUsPage(),
            ],
          ),
        )
      )
    );
  }
}


