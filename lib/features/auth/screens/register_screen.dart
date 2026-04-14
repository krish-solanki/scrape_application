import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_strings.dart';
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

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings("en");
    final theme = Theme.of(context); 

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
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

                      // 🔹 Title
                      Text(
                        'Create Account',
                        style: theme.textTheme.headlineLarge,
                      ),

                      SizedBox(height: 6.h),

                      Text(
                        "Sign up to get started!",
                        style: theme.textTheme.bodyMedium,
                      ),

                      SizedBox(height: 25.h),

                      // 🔹 Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
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
                              hintText: 'Enter full name',
                              icon: Icons.person,
                            ),

                            SizedBox(height: 12.h),

                            buildTextField(
                              context: context,
                              hintText: 'Enter your email',
                              icon: Icons.email,
                            ),

                            SizedBox(height: 12.h),

                            buildTextField(
                              context: context,
                              hintText: 'Create a password',
                              icon: Icons.lock_outline,
                              isPassword: true,
                            ),

                            SizedBox(height: 12.h),

                            buildTextField(
                              context: context,
                              hintText: 'Confirm password',
                              icon: Icons.lock_outline,
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // 🔹 Checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: 0.9,
                            child: Checkbox(
                              value: isChecked,
                              activeColor:
                                  theme.colorScheme.secondary,
                              side: BorderSide(
                                color: theme.dividerColor,
                              ),
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
                                style: theme.textTheme.bodyMedium,
                                children: [
                                  const TextSpan(text: "I accept the "),
                                  TextSpan(
                                    text: "Terms of Service",
                                    style: TextStyle(
                                      color:
                                          theme.colorScheme.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(text: " & "),
                                  TextSpan(
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                      color:
                                          theme.colorScheme.secondary,
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

                      // 🔹 Button
                      buildButton(
                        context: context,
                        text: strings.signUp,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 20.h),

                      // 🔹 Bottom Text
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: theme.textTheme.bodyMedium,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            strings.signIn,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.secondary,
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
          ),
        ),
      ),
    );
  }
}