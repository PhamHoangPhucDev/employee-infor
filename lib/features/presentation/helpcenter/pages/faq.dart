import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../data/models/prCode_model.dart';
import '../widgets/expansion_panel_list_radio.dart';
import '../widgets/outline_tabBar.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> with TickerProviderStateMixin {
  late TabController faqTabController;
  List<String> listInnerTabView = ["Chủ Đề", "Tổng Quan", "Dịch Vụ"];

  // Mỗi tab có danh sách riêng
  List<PrCodeModel> itemsTab1 = [
    PrCodeModel(id: 1, name: "Lorem ipsum dolor sit amet?", subname: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam."),
    PrCodeModel(id: 2, name: "Panel 2", subname: "Content 2"),
  ];
  List<PrCodeModel> itemsTab2 = [
    PrCodeModel(id: 3, name: "Panel A", subname: "Content A"),
    PrCodeModel(id: 4, name: "Panel B", subname: "Content B"),
  ];
  List<PrCodeModel> itemsTab3 = [
    PrCodeModel(id: 5, name: "Panel X", subname: "Content X"),
    PrCodeModel(id: 6, name: "Panel Y", subname: "Content Y"),
  ];

  @override
  void initState() {
    faqTabController = TabController(length: listInnerTabView.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    faqTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: AppColors.background, 
          child: OutlineTabBar(
            controller: faqTabController,
            tabs: listInnerTabView,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: faqTabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              ExpansionPanelListRadio(items: itemsTab1, tabIndex: 0),
              ExpansionPanelListRadio(items: itemsTab2, tabIndex: 1),
              ExpansionPanelListRadio(items: itemsTab3, tabIndex: 2),
            ],
          ),
        ),
      ],
    );
  }
}
