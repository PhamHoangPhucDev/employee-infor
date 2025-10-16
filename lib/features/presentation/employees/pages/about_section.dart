import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Tổng quan", style: AppTypography.body(color: AppColors.primary)),
        const SizedBox(height: 8),
        Text(
          "\tHiện tại, mình là sinh viên năm cuối tại Đại học Hoa Sen và đang thực tập tại một công ty khởi nghiệp trong nước (về giáo dục). Trong tương lai, mình hy vọng có cơ hội tìm hiểu thêm về ML/Al để phát triển những điều mới mẻ, đóng góp cho cộng đồng. Sở thích của mình là chia sẻ kiến ​​thức, những ý tưởng nhỏ và nghiên cứu; biết đâu nó có thể giúp bạn cải thiện dự án và làm giàu kiến ​​thức của mình.\nGithub: https://github.com/Tam NguyenMinh2494",
          style: AppTypography.smallbody(),
        ),
        const SizedBox(height: 20),
        Text("Điểm mạnh", style: AppTypography.body(color: AppColors.primary)),
        const SizedBox(height: 8),
        Text(
          "- Làm việc nhóm tốt\n- Giải quyết vấn đề nhanh chóng\n- Học hỏi nhanh",
          style: AppTypography.smallbody(),
        ),
        const SizedBox(height: 20),
        Text("Sở thích", style: AppTypography.body(color: AppColors.primary)),
        const SizedBox(height: 8),
        Text("\tĐọc sách, du lịch, nghiên cứu UI/UX",style: AppTypography.smallbody(),),
      ],
    );
  }
}