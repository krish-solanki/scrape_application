import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';
import 'package:scrape_application/features/auth/widgets/custom_button.dart';
import 'package:scrape_application/features/auth/widgets/custom_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isBiometricEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back, color: AppColors.textPrimary),
                      SizedBox(width: 10.w),
                      Text("Edit Profile", style: AppTextStyles.heading),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.highlight,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text("Save", style: AppTextStyles.button),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2.w,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 45.r,
                        backgroundImage: const NetworkImage(
                          "https://i.pravatar.cc/300",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: AppColors.highlight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.edit, size: 16.sp, color: Colors.black),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),
              buildTextField(
                context: context,
                hintText: 'Name',
                icon: Icons.person,
              ),

              buildTextField(
                context: context,
                hintText: 'Email',
                icon: Icons.email,
              ),

              buildTextField(
                context: context,
                hintText: 'Phone',
                icon: Icons.phone,
              ),

              SizedBox(height: 20.h),

              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Security", style: AppTextStyles.subHeading),
                    SizedBox(height: 12.h),

                    Row(
                      children: [
                        Icon(Icons.lock, color: AppColors.primary),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Change Password",
                                style: AppTextStyles.body,
                              ),
                              Text(
                                "Update your account password",
                                style: AppTextStyles.label,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    Row(
                      children: [
                        Icon(Icons.fingerprint, color: AppColors.primary),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            "Enable Biometric Login",
                            style: AppTextStyles.body,
                          ),
                        ),
                        Switch(
                          value: isBiometricEnabled,
                          activeColor: AppColors.highlight,
                          onChanged: (val) {
                            setState(() {
                              isBiometricEnabled = val;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              buildButton(context: context, text: 'Logout', onPressed: null),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
