import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrape_application/core/constants/app_loader.dart';
import 'package:scrape_application/core/utils/loaderHelper.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';
import 'package:scrape_application/features/scan/services/local_scan_service.dart';
import 'package:scrape_application/features/scan/services/scan_service.dart';
import 'package:image/image.dart' as img;

class ScanController extends ChangeNotifier {
  File? capturedImage;
  String? prediction;
  double confidence = 0;
  final LocalScanService localScanService = LocalScanService();

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

  Future<void> saveScan({
    required String userId,
    required String name,
    required double weight,
    required double pricePerKg,
    String description = '',
  }) async {
    try {
      if (prediction == null || capturedImage == null) {
        return;
      }

      final totalAmount = weight * pricePerKg;

      final imageBase64 = await imageToBase64(capturedImage!);

      final scan = ScanModel(
        userId: userId,
        scanId: '',
        name: name,
        scrapType: prediction!,
        confidence: confidence,
        weight: weight,
        unit: 'kg',
        isFavourite: false,
        imageUrl: imageBase64,
        estimatedPrice: totalAmount,
        description: description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await scanService.saveData(scan);

      debugPrint("Scan Saved Successfully");
    } catch (e) {
      debugPrint("Save Scan Error : $e");
    }
  }

  Future<void> saveLocalScan({
    required BuildContext context,
    required String userId,
    required String name,
    required double weight,
    required double estimatedPrice,
    required String description,
  }) async {
    try {
      if (prediction == null || capturedImage == null) {
        return;
      }
      LoaderHelper.show(context);
      final imageBase64 = await imageToBase64(capturedImage!);
      final scan = ScanModel(
        userId: userId,
        scanId: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        scrapType: prediction!,
        confidence: confidence,
        weight: weight,
        unit: 'kg',
        isFavourite: false,
        imageUrl: imageBase64,
        estimatedPrice: estimatedPrice,
        description: description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await localScanService.localSaveScan(scan);
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
}
