// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scrape_application/core/utils/loaderHelper.dart';
import 'package:scrape_application/features/auth/controllers/auth_controller.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';
import 'package:scrape_application/features/scan/services/local_scan_service.dart';
import 'package:scrape_application/features/scan/services/online_scan_service.dart';
import 'package:scrape_application/features/scan/services/scan_service.dart';
import 'package:image/image.dart' as img;

class ScanController extends ChangeNotifier {
  File? capturedImage;
  String? prediction;
  double confidence = 0;
  final LocalScanService localScanService = LocalScanService();
  final OnlineScanService onlineScanService = OnlineScanService();
  final ScanService scanService = ScanService();

  bool isLoading = false;

  File? get image => capturedImage;

  Future<void> initializeModel() async {
    try {
      isLoading = true;
      notifyListeners();
      await scanService.loadModel();
      debugPrint("Model Loaded Successfully");
    } catch (e) {
      debugPrint("Model Load Error : $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> predictMetal() async {
    try {
      prediction = "";
      confidence = 0;
      debugPrint("predictMetal called");
      if (capturedImage == null) return;
      final result = await scanService.predictImage(capturedImage!);
      prediction = result["label"];
      confidence = result["confidence"];

      notifyListeners();

      debugPrint(
        "Prediction: $prediction (${(confidence * 100).toStringAsFixed(2)}%)",
      );
      debugPrint("predictMetal ended");
    } catch (e) {
      debugPrint("Preducation Error: ${e.toString()}");
    }
  }

  Future<void> saveOnlineScan({
    required BuildContext context,
    required String name,
    required double weight,
    required double estimatedPrice,
    required String description,
    required String location,
  }) async {
    try {
      if (prediction == null || capturedImage == null) {
        return;
      }
      LoaderHelper.show(context);
      if (FirebaseAuth.instance.currentUser == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login First')));
        return;
      }
      final totalAmount = weight * estimatedPrice;
      final imageBase64 = await imageToBase64(capturedImage!);
      final scanId = FirebaseFirestore.instance.collection('scans').doc().id;
      final scan = ScanModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        scanId: scanId,
        name: name,
        scrapType: prediction!,
        confidence: confidence,
        weight: weight,
        unit: 'kg',
        location: location,
        isFavourite: false,
        imageUrl: imageBase64,
        estimatedPrice: estimatedPrice,
        totalPrice: totalAmount,
        description: description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await onlineScanService.onlineSaveScan(scan);
      removeData();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data Saved Successfully')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      LoaderHelper.hide(context);
    }
  }

  Future<void> saveLocalScan({
    required BuildContext context,
    required String name,
    required double weight,
    required double estimatedPrice,
    required String description,
    required String location,
  }) async {
    try {
      // final isLogin = await AuthController.isLoggedIn(context: context);
      if (prediction == null || capturedImage == null) {
        return;
      }
      // if (!isLogin) return;
      // debugPrint('Is Login Value ${isLogin}');
      LoaderHelper.show(context);
      final totalPrice = weight * estimatedPrice;
      final imageBase64 = await imageToBase64(capturedImage!);
      final scan = ScanModel(
        userId: FirebaseAuth.instance.currentUser!.uid,
        scanId: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        scrapType: prediction!,
        confidence: confidence,
        location: location,
        weight: weight,
        unit: 'kg',
        isFavourite: false,
        imageUrl: imageBase64,
        estimatedPrice: estimatedPrice,
        totalPrice: totalPrice,
        description: description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await localScanService.localSaveScan(scan);
      removeData();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Data Saved Successfully')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      LoaderHelper.hide(context);
    }
  }

  Future<String> imageToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception('Image decode failed');
    }
    final resized = img.copyResize(image, width: 224, height: 224);
    final compressed = img.encodeJpg(resized, quality: 60);
    return base64Encode(compressed);
  }

  void setImage(File image) {
    capturedImage = image;
    notifyListeners();
  }

  void removeImage() {
    capturedImage = null;
    notifyListeners();
  }

  void removeData() async {
    if (capturedImage != null) {
      await capturedImage!.delete();
    }
    capturedImage = null;
    prediction = null;
    confidence = 0;
    notifyListeners();
  }
}
