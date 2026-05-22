import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_strings.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';
import 'package:scrape_application/core/utils/redirectionHelper.dart';
import 'package:scrape_application/features/auth/controllers/auth_controller.dart';
import 'package:scrape_application/features/auth/screens/login_screen.dart';
import 'package:scrape_application/features/auth/widgets/custom_button.dart';
import 'package:scrape_application/features/auth/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<AuthController>(
            builder: (context, controller, child) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.h),

                          Text(
                            strings.createAccount,
                            style: AppTextStyles.heading.copyWith(
                              fontSize: 28.sp,
                            ),
                          ),

                          SizedBox(height: 6.h),

                          Text(
                            strings.signUpGetStarted,
                            style: AppTextStyles.body,
                          ),

                          SizedBox(height: 25.h),

                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(18.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Column(
                              children: [
                                buildTextField(
                                  context: context,
                                  hintText: strings.enterName,
                                  icon: Icons.person,
                                  controller: nameController,
                                ),

                                SizedBox(height: 12.h),

                                buildTextField(
                                  context: context,
                                  hintText: strings.enterEmail,
                                  icon: Icons.email,
                                  controller: emailController,
                                ),

                                SizedBox(height: 12.h),

                                buildTextField(
                                  context: context,
                                  hintText: strings.enterPassword,
                                  icon: Icons.lock_outline,
                                  isPassword: true,
                                  controller: passwordController,
                                ),

                                SizedBox(height: 12.h),

                                buildTextField(
                                  context: context,
                                  hintText: strings.enterConfirmPassword,
                                  icon: Icons.lock_outline,
                                  isPassword: true,
                                  controller: confirmPasswordController,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 16.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.scale(
                                scale: 0.9,
                                child: Checkbox(
                                  value: isChecked,
                                  activeColor: AppColors.highlight,
                                  checkColor: Colors.black,
                                  side: BorderSide(color: AppColors.border),
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                              ),

                              SizedBox(width: 6.w),

                              Flexible(
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: AppTextStyles.body,
                                    children: [
                                      TextSpan(text: strings.acceptTerms),
                                      TextSpan(
                                        text: strings.termsOfService,
                                        style: TextStyle(
                                          color: AppColors.highlight,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const TextSpan(text: " & "),
                                      TextSpan(
                                        text: strings.privacyPolicy,
                                        style: TextStyle(
                                          color: AppColors.highlight,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          buildButton(
                            context: context,
                            text: strings.signUp,
                            onPressed: () => controller.register(
                              context: context,
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              confirmPassword: confirmPasswordController.text
                                  .trim(),
                              isChecked: isChecked,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                strings.alreadyHaveAccount,
                                style: AppTextStyles.body,
                              ),

                              SizedBox(width: 6.w),

                              GestureDetector(
                                onTap: () =>
                                    PageRedirectionHelper.popScreenRedirection(
                                      context: context,
                                      widget: LoginScreen(),
                                    ),
                                child: Text(
                                  strings.signIn,
                                  style: AppTextStyles.subHeading.copyWith(
                                    color: AppColors.highlight,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 30.h),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
