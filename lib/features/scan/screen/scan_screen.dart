import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/features/scan/controllers/scan_controller.dart';
import 'package:scrape_application/features/scan/widgets/custom_corner.dart';
import 'package:scrape_application/main.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? cameraController;

  Future<void>? initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras.first, ResolutionPreset.high);
    initializeControllerFuture = cameraController!.initialize();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ScanController>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  Text(
                    "AI Scrap Scanner",
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 40.h),

                  Center(
                    child: Container(
                      width: 280.w,
                      height: 400.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24.r),
                            child: SizedBox(
                              width: 280.w,
                              height: 400.h,
                              child: provider.capturedImage == null
                                  ? CameraPreview(cameraController!)
                                  : Image.file(
                                      provider.capturedImage!,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),

                          SizedBox(
                            width: 280.w,
                            height: 400.h,
                            child: Stack(
                              children: [
                                buildCorner(top: true, left: true),
                                buildCorner(top: true, left: false),
                                buildCorner(top: false, left: true),
                                buildCorner(top: false, left: false),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  provider.capturedImage == null
                      ? GestureDetector(
                          onTap: captureImage,
                          child: Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 35,
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    provider.removeImage();
                                  },
                                  child: Container(
                                    height: 55.h,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(width: 16.w),

                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    if (provider.capturedImage != null) {
                                      await provider.detectLabels(
                                        provider.capturedImage!,
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 55.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Done",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> captureImage() async {
    final provider = Provider.of<ScanController>(context, listen: false);

    try {
      await initializeControllerFuture;
      final image = await cameraController!.takePicture();
      provider.setImage(File(image.path));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:scrape_application/core/constants/app_colors.dart';
// import 'package:scrape_application/core/utils/redirectionHelper.dart';
// import 'package:scrape_application/features/scan/controllers/scan_controller.dart';
// import 'package:scrape_application/features/scan/widgets/custom_corner.dart';
// import 'package:scrape_application/main.dart';
// import 'package:scrape_application/shared/widgets/bottom_nav_bar.dart';

// class ScanScreen extends StatefulWidget {
//   const ScanScreen({super.key});

//   @override
//   State<ScanScreen> createState() => _ScanScreenState();
// }

// class _ScanScreenState extends State<ScanScreen> {
//   CameraController? controller;
//   Future<void>? initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     controller = CameraController(cameras.first, ResolutionPreset.high);
//     initializeControllerFuture = controller!.initialize();
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ScanController>(context);

//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: FutureBuilder(
//         future: initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return SafeArea(
//               child: Stack(
//                 children: [
//                   Column(
//                     children: [
//                       SizedBox(height: 20.h),

//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20.w),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GestureDetector(
//                               onTap: () =>
//                                   PageRedirectionHelper.popScreenRedirection(
//                                     context: context,
//                                     widget: AppBottomNav(),
//                                   ),
//                               child: Container(
//                                 padding: EdgeInsets.all(10.w),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade200,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(Icons.arrow_back),
//                               ),
//                             ),

//                             Text(
//                               "Scan Scrap",
//                               style: TextStyle(
//                                 fontSize: 20.sp,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),

//                             Container(
//                               padding: EdgeInsets.all(10.w),
//                               decoration: BoxDecoration(
//                                 color: AppColors.primary.withOpacity(0.15),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: Icon(
//                                 Icons.camera_alt,
//                                 color: AppColors.primary,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       SizedBox(height: 40.h),

//                       Center(
//                         child: Container(
//                           width: 280.w,
//                           height: 350.h,
//                           decoration: BoxDecoration(
//                             color: Colors.black,
//                             borderRadius: BorderRadius.circular(24.r),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.15),
//                                 blurRadius: 20,
//                                 offset: const Offset(0, 10),
//                               ),
//                             ],
//                           ),
//                           child: Stack(
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(24.r),
//                                 child: SizedBox(
//                                   width: 280.w,
//                                   height: 350.h,
//                                   child: provider.capturedImage == null
//                                       ? CameraPreview(controller!)
//                                       : Image.file(
//                                           provider.capturedImage!,
//                                           fit: BoxFit.cover,
//                                         ),
//                                 ),
//                               ),

//                               SizedBox(
//                                 width: 280.w,
//                                 height: 350.h,
//                                 child: Stack(
//                                   children: [
//                                     buildCorner(top: true, left: true),
//                                     buildCorner(top: true, left: false),
//                                     buildCorner(top: false, left: true),
//                                     buildCorner(top: false, left: false),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: 25.h),

//                       Text(
//                         provider.capturedImage == null
//                             ? "Align scrap inside frame"
//                             : "Photo captured successfully",
//                         style: TextStyle(
//                           fontSize: 15.sp,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),

//                       const Spacer(),

//                       provider.capturedImage == null
//                           ? GestureDetector(
//                               onTap: captureImage,
//                               child: Container(
//                                 width: 80.w,
//                                 height: 80.h,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: AppColors.primary,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: AppColors.primary.withOpacity(0.4),
//                                       blurRadius: 20,
//                                     ),
//                                   ],
//                                 ),
//                                 child: const Icon(
//                                   Icons.camera_alt,
//                                   color: Colors.black,
//                                   size: 35,
//                                 ),
//                               ),
//                             )
//                           : Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 20.w),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         provider.removeImage();
//                                       },
//                                       child: Container(
//                                         height: 55.h,
//                                         decoration: BoxDecoration(
//                                           color: Colors.red.shade50,
//                                           borderRadius: BorderRadius.circular(
//                                             16.r,
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             "Cancel",
//                                             style: TextStyle(
//                                               color: Colors.red,
//                                               fontSize: 16.sp,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),

//                                   SizedBox(width: 16.w),

//                                   Expanded(
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         sendImage();
//                                       },
//                                       child: Container(
//                                         height: 55.h,
//                                         decoration: BoxDecoration(
//                                           color: AppColors.primary,
//                                           borderRadius: BorderRadius.circular(
//                                             16.r,
//                                           ),
//                                         ),
//                                         child: Center(
//                                           child: Text(
//                                             "Done",
//                                             style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 16.sp,
//                                               fontWeight: FontWeight.w700,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),

//                       SizedBox(height: 50.h),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }

//           if (snapshot.hasError) {
//             return const Center(child: Text("Camera Error"));
//           }

//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }

//   Future<void> captureImage() async {
//     final provider = Provider.of<ScanController>(context, listen: false);
//     try {
//       await initializeControllerFuture;
//       final image = await controller!.takePicture();
//       provider.setImage(File(image.path));
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }

//   Future<void> sendImage() async {
//     final controller = Provider.of<ScanController>(context, listen: false);
//     try {
//       await initializeControllerFuture;

//       final image = await controller!.takePicture();

//       final file = File(image.path);

//       provider.setImage(file);

//       await controller.detectObject(file);
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//   }
// }
