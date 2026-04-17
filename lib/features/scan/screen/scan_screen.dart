import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scrape_application/core/constants/app_colors.dart';
import 'package:scrape_application/features/scan/widgets/custom_corner.dart';
import 'package:scrape_application/main.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  CameraController? controller;
  Future<void>? _initializeControllerFuture;

  File? capturedImage;

  @override
  void initState() {
    super.initState();

    controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = controller!.initialize();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned.fill(
                  child: capturedImage == null
                      ? CameraPreview(controller!)
                      : Image.file(
                          capturedImage!,
                          fit: BoxFit.cover,
                        ),
                ),

                // 🔝 TOP BAR
                Positioned(
                  top: 40,
                  left: 16,
                  right: 16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.white),
                      Text(
                        "Scan & Measure",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Icon(Icons.camera_alt, color: Colors.amber),
                    ],
                  ),
                ),

                // 🔲 SCAN BOX
                Center(
                  child: SizedBox(
                    width: 250,
                    height: 180,
                    child: Stack(
                      children: [
                        buildCorner(top: true, left: true),
                        buildCorner(top: true, left: false),
                        buildCorner(top: false, left: true),
                        buildCorner(top: false, left: false),
                      ],
                    ),
                  ),
                ),

                // 📊 TEXT
                Positioned(
                  bottom: 180,
                  left: 20,
                  right: 20,
                  child: Column(
                    children: const [
                      Text(
                        "DETECTION: STAINLESS STEEL 304, 85% CONFIDENCE",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "EST. DIMENSIONS: L: 32cm, W: 15cm, T: 6mm",
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ),

                // 🎯 CAPTURE BUTTON
                Positioned(
                  bottom: 90,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: _captureImage,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.6),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.camera, color: Colors.black),
                      ),
                    ),
                  ),
                ),

                // 📷 BOTTOM ICONS
                Positioned(
                  bottom: 20,
                  left: 30,
                  right: 30,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.photo, color: Colors.white),
                      Icon(Icons.flip_camera_ios, color: Colors.white),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Camera Error",
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  // 📸 CAPTURE IMAGE
  Future<void> _captureImage() async {
    try {
      await _initializeControllerFuture;
      final image = await controller!.takePicture();

      setState(() {
        capturedImage = File(image.path);
      });
    } catch (e) {
      print(e);
    }
  }
}