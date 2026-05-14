import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_strings.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';
import 'package:scrape_application/core/utils/loaderHelper.dart';
import 'package:scrape_application/features/auth/screens/register_screen.dart';
import 'package:scrape_application/features/auth/widgets/custom_button.dart';
import 'package:scrape_application/features/auth/widgets/custom_textfield.dart';
import 'package:scrape_application/shared/widgets/bottom_nav_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  strings.welcomeBack,
                  style: AppTextStyles.heading.copyWith(fontSize: 28.sp),
                ),

                SizedBox(height: 6.h),

                Text(strings.signIn, style: AppTextStyles.body),

                SizedBox(height: 24.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 18.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Column(
                      children: [
                        buildTextField(
                          context: context,
                          hintText: strings.enterEmail,
                          icon: Icons.person,
                        ),

                        SizedBox(height: 14.h),

                        buildTextField(
                          context: context,
                          hintText: strings.enterPassword,
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        SizedBox(height: 10.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            strings.forgotPassword,
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.primary,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        buildButton(
                          context: context,
                          text: strings.login,
                          onPressed: () {
                            redirection(context, AppBottomNav());
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(strings.dontHaveAccount, style: AppTextStyles.body),

                    SizedBox(width: 5.w),

                    GestureDetector(
                      onTap: () {
                        redirection(context, RegisterScreen());
                      },
                      child: Text(
                        strings.signUp,
                        style: AppTextStyles.subHeading.copyWith(
                          color: AppColors.highlight,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void redirection(BuildContext context, Widget widget) async {
    LoaderHelper.show(context);
    await Future.delayed(const Duration(seconds: 3));
    LoaderHelper.hide(context);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );
  }
}
