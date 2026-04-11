import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_strings.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';
import 'package:scrape_application/features/auth/widgets/custom_button.dart';
import 'package:scrape_application/features/auth/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings("en");

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Welcome Back', style: AppTextStyles.heading),

                SizedBox(height: 5.h),

                Text('Sign in to your account', style: AppTextStyles.body),

                SizedBox(height: 20.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        buildTextField(
                          context: context,
                          hintText: strings.enterEmail,
                          icon: Icons.person,
                        ),

                        SizedBox(height: 12.h),

                        buildTextField(
                          context: context,
                          hintText: strings.enterPassword,
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),

                        SizedBox(height: 8.h),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            strings.forgotPassword,
                            style: AppTextStyles.label.copyWith(
                              color: AppColors.highlight,
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        buildButton(text: strings.login, onPressed: () {}),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(strings.dontHaveAccount, style: AppTextStyles.body),
                    SizedBox(width: 5.w),
                    Text(
                      strings.signUp,
                      style: AppTextStyles.subHeading.copyWith(
                        color: AppColors.highlight,
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
}
