import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_strings.dart';
import 'package:scrape_application/features/auth/screens/register_screen.dart';
import 'package:scrape_application/features/auth/widgets/custom_button.dart';
import 'package:scrape_application/features/auth/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings("en");
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome Back',
                  style: theme.textTheme.headlineLarge,
                ),

                SizedBox(height: 5.h),

                Text(
                  'Sign in to your account',
                  style: theme.textTheme.bodyMedium,
                ),

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
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: theme.dividerColor,
                      ),
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
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),

                        SizedBox(height: 20.h),

                        buildButton(
                          context: context,
                          text: strings.login,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      strings.dontHaveAccount,
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      strings.signUp,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.secondary,
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