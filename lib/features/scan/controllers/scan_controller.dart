import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';

class ScanController extends ChangeNotifier {
  File? capturedImage;

  final ImageLabeler imageLabeler = ImageLabeler(
    options: ImageLabelerOptions(confidenceThreshold: 0.5),
  );

  void setImage(File image) {
    capturedImage = image;
    notifyListeners();
  }

  void removeImage() {
    capturedImage = null;
    notifyListeners();
  }

  Future<void> detectLabels(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final labels = await imageLabeler.processImage(inputImage);
      print("============== AI LABELS ==============");
      if (labels.isEmpty) {
        print("No Labels Found");
      }
      for (ImageLabel label in labels) {
        print("Label: ${label.label}");
        print("Confidence: ${label.confidence}");
        print("Index: ${label.index}");
        print("--------------------------------");
      }
      print("=======================================");
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    imageLabeler.close();
    super.dispose();
  }
}
