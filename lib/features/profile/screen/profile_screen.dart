import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/core/constants/app_text_style.dart';
import 'package:scrape_application/features/auth/controllers/auth_controller.dart';
import 'package:scrape_application/features/auth/widgets/custom_textfield.dart';
import 'package:scrape_application/features/profile/controller/profile_controller.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isBiometricEnabled = true;

  final imagePicker = ImagePicker();
  String selectedImage = "";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final controller = context.read<ProfileController>();
    await controller.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Consumer<ProfileController>(
            builder: (context, controller, child) {
              if (controller.user == null) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Edit Profile", style: AppTextStyles.heading),
                      GestureDetector(
                        onTap: () async {
                          await context.read<ProfileController>().updateProfile(
                            context: context,
                            name: nameController.text,
                            phone: phoneController.text,
                            image: selectedImage.isNotEmpty
                                ? selectedImage
                                : controller.user?.image ?? "",
                          );
                        },
                        child: Container(
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
                      ),
                    ],
                  ),

                  SizedBox(height: 30.h),

                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
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
                              backgroundImage: selectedImage.isNotEmpty
                                  ? MemoryImage(base64Decode(selectedImage))
                                  : controller.user!.image.isNotEmpty
                                  ? MemoryImage(
                                      base64Decode(controller.user!.image),
                                    )
                                  : const NetworkImage(
                                      'https://i.pravatar.cc/150?img=3',
                                    ),
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: AppColors.highlight,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 16.sp,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  buildTextField(
                    context: context,
                    hintText: controller.user?.name ?? "",
                    icon: Icons.person,
                    controller: nameController,
                  ),

                  buildTextField(
                    context: context,
                    hintText: controller.user?.email ?? "",
                    icon: Icons.email,
                    controller: emailController,
                    isEmail: true,
                  ),

                  buildTextField(
                    context: context,
                    hintText: controller.user?.phone ?? "",
                    icon: Icons.phone,
                    controller: phoneController,
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
                              thumbColor: WidgetStatePropertyAll(
                                AppColors.highlight,
                              ),
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

                  SizedBox(
                    height: 45.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await context.read<AuthController>().logout(
                          context: context,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.highlight,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text('Logout', style: AppTextStyles.button),
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final XFile? file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (file == null) return;
    Uint8List imageBytes = await file.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    setState(() {
      selectedImage = base64Image;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
