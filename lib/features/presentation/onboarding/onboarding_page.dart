import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/components/button/text_button_component.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import 'widgets/slide_item.dart';
import 'onboarding_controller.dart';

class OnboardingPage extends GetView<OnboardingController> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (i) => controller.updatePage(i),
                  itemCount: controller.slides.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (ctx, i) {
                    final slide = controller.slides[i];
                    return SlideItem(
                      title: slide.name!,
                      description: slide.subname!,
                      imagePath: slide.body1!,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 23.h),
                child: SmoothPageIndicator(
                  controller: controller.pageController,
                  count: controller.slides.length,
                  effect: WormEffect(
                    activeDotColor: AppColors.primary,
                    dotHeight: 8,
                    dotWidth: 8,
                    type: WormType.normal,
                  ),
                ),
              ),
            ],
          ),

          // Skip button
          Obx(() => !controller.isLastPage.value
              ? Positioned(
                  top: 40,
                  right: 20,
                  child: TextButton(
                    onPressed: controller.goToLogin,
                    child: Text(AppStrings.skipButton,style: AppTypography.button(color: AppColors.text),),
                  ),
                )
              : const SizedBox.shrink(), // ẩn hoàn toàn
          ),

          // Next / Done button
          Positioned(
            bottom: 24,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AppImages.onboarding_ellipse2),
                Obx(() => TextButtonComponent(
                      onPressed: () => controller.nextPage(controller.pageController),
                      title: controller.isLastPage.value ? AppStrings.getstartedButton : AppStrings.nextButton,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
