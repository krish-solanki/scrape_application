import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scrape_application/features/scan/services/scan_service.dart';

class ScanController extends ChangeNotifier {
  File? capturedImage;
  String? prediction;
  double confidence = 0;

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

  void setImage(File image) {
    capturedImage = image;
    notifyListeners();
  }

  void removeImage() {
    capturedImage = null;
    notifyListeners();
  }
}
