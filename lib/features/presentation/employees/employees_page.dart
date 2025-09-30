import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:sizer/sizer.dart';

import '../../../core/components/app_appBar.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'widgets/category_listItem.dart';
import 'pages/infoEmployee_page.dart';
import 'employees_controller.dart';

class EmployeesPage extends StatelessWidget {
  EmployeesPage({super.key});


  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final controller = Get.put(EmployeesController());

    scrollController.addListener(() {
      controller.updateHeight(scrollController.offset);
    });


    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.employeesTitle),
      body: Column(
        children: [
          // widget phía trên (sẽ ẩn dần khi scroll)
          Obx(() => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: controller.bannerHeight.value,
                color: AppColors.primary,
                alignment: Alignment.center,
                child: Text("Quản Lý Và Theo Dõi Danh Sách Nhân Viên Dễ Dàng Ngay Tại Đây.",
                  style: AppTypography.smallbody(color: AppColors.textLight),
                ),
              )),

          // search luôn hiện
          Container(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
            color: AppColors.primary,
            child: TextField(
              style: AppTypography.button(color: AppColors.primary),
              decoration: InputDecoration(
                hintText: "Tìm kiếm...",
                hintStyle: AppTypography.body(color: AppColors.primary),
                filled: true,
                fillColor: AppColors.background,
                prefixIcon:  Icon(Icons.search,color: AppColors.primary,),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: AppColors.background, // viền
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: AppColors.background, // viền khi chưa focus
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: AppColors.background, // viền khi focus
                    width: 3,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          //Danh sách loại
          CategoryListItem(
            icons: [
              HugeIcons.strokeRoundedUserGroup, // HR
              HugeIcons.strokeRoundedCalculate,          // Accounting
              HugeIcons.strokeRoundedComputerUser,           // IT
              HugeIcons.strokeRoundedMegaphone01,           // Marketing
              HugeIcons.strokeRoundedShoppingCart01,      // Sales
              HugeIcons.strokeRoundedUserList,         // Admin
              HugeIcons.strokeRoundedFactory,            // Operations
              HugeIcons.strokeRoundedManager,    // Management
            ],
            onItemSelected: (index) {
              print("Bạn chọn item: $index");
            },
          ),
          Divider(color: AppColors.buttonLight,height: 10,indent: 20,endIndent: 20,),

          //filter
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0,),
            child: Row(
              children: [
                Text("Sắp xếp theo",style: AppTypography.smallbody(),),
                SizedBox(width: 5,),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primary, // màu nền
                    minimumSize: Size(50, 25), // chiều rộng và cao nhỏ lại
                    padding: EdgeInsets.zero, // bỏ padding mặc định nếu muốn
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: (){
                    print("A->Z");
                  },
                  child: Text("A->Z",style: AppTypography.button(color: AppColors.textLight),)
                ),
                SizedBox(width: 5,),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.background, // màu nền
                    minimumSize: Size(50, 25), // chiều rộng và cao nhỏ lại
                    padding: EdgeInsets.zero, // bỏ padding mặc định nếu muốn
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: AppColors.primary,width: 1.5)
                    ),
                  ),
                  onPressed: (){
                    print("Hiện filter");
                  },
                  child: Text("Filter",style: AppTypography.button(color: AppColors.primary),)
                ),
              ],
            ),
          ),

          Divider(color: AppColors.buttonLight,height: 10,indent: 20,endIndent: 20,),

          // danh sách
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: 10,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  // backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
                  child: Icon(Icons.person,)
                ),
                title: Text("Nguyễn Văn A${index}",style: AppTypography.body(color: AppColors.primary),),
                subtitle: Text("Nhân viên ${index}",style: AppTypography.smallbody(),),
                trailing: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.background, // màu nền
                    minimumSize: Size(50, 25), // chiều rộng và cao nhỏ lại
                    padding: EdgeInsets.zero, // bỏ padding mặc định nếu muốn
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: AppColors.primary,width: 1.5)
                    ),
                  ),
                  onPressed: (){
                    print("Chuyển page Info Nguyễn Văn A${index}");
                    Get.to(() => InfoEmployeePage());
                  },
                  child: Text("Info",style: AppTypography.button(color: AppColors.primary),)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}