import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../core/components/appBar_component.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../data/models/user_model.dart';
import 'widgets/item_benefit_tile.dart';

class EmployeebenefitsPage extends StatelessWidget {
  EmployeebenefitsPage({super.key});

  UserModel user = UserModel(
    id: "1",
    email: "abc@gmail.com",
    fullname: "Nguyễn Văn A",
    exp: "10 Năm",
    gender: "Nam",
    role: "Senior",
    yearsOfService: "2 Năm",
    birthday: "10/10/2022",
    mobile: "0999999999",
    password: "123456"
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: AppStrings.employeebenefitsTitle,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: CustomScrollView(
          slivers: [
             // Thông tin nhân viên
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(user.fullname,style: AppTypography.subtitle(color: AppColors.primary),),
                  Divider(color: AppColors.backgroundInput,),
                ],
              ),
            ),
            //Lưới thông tin cơ bản
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 50,
                  childAspectRatio: 6,
                ),
                delegate: SliverChildListDelegate(
                  [
                    buildGridItem("Giới tính", user.gender),
                    buildGridItem("Chức vụ", user.role),
                    buildGridItem("Kinh nghiệm", user.exp),
                    buildGridItem("Thâm niên", user.yearsOfService),
                  ],
                ),
              ),
            ),
            //Tiêu đề phần chế độ đãi ngộ 
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: AppColors.backgroundInput,),
                  Text("Chế Độ Đãi Ngộ",style: AppTypography.subtitle(),),
                  Text("Hiện có",style: AppTypography.smallbody(),),
                  Divider(color: AppColors.backgroundInput,),
                ],
              ),
            ),
            //Danh sách chế độ
             SliverList(
              delegate: SliverChildListDelegate([
                ItemBenefitTile(
                  title: "Bảo Hiểm",
                  subtitle: "Xã Hội - Y Tế - Thất Nghiệp - Tai Nạn Lao Động - Nhân Thọ",
                  icon: HugeIcons.strokeRoundedUserShield01,
                ),
                ItemBenefitTile(
                  title: "Chế Độ Nghỉ Phép",
                  subtitle: "12 ngày/năm, thưởng thêm theo thâm niên",
                  icon: HugeIcons.strokeRoundedCalendar02,
                ),
                ItemBenefitTile(
                  title: "Thưởng & Phụ Cấp",
                  subtitle: "Lương tháng 13, thưởng KPI, hỗ trợ ăn trưa",
                  icon: HugeIcons.strokeRoundedAward01,
                ),
                ItemBenefitTile(
                  title: "Đào Tạo & Phát Triển",
                  subtitle: "Các khóa học nội bộ và chứng chỉ quốc tế",
                  icon: HugeIcons.strokeRoundedGraduationScroll,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildGridItem(String title, String? value) {
  return Text.rich(
    TextSpan(
      text: '$title: ',
      style: AppTypography.smallbody(),
      children: [
        TextSpan(
          text: '$value',
          style: AppTypography.body(color: AppColors.primary), 
        ),
      ],
    ),
  );
}
