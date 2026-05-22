import 'dart:io';

import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

class ScanService {
  final ObjectDetector objectDetector = ObjectDetector(
    options: ObjectDetectorOptions(
      mode: DetectionMode.stream,
      classifyObjects: true,
      multipleObjects: true,
    ),
  );

  Future<void> detectObject(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final objects = await objectDetector.processImage(inputImage);
      print("============== AI RESULT ==============");
      if (objects.isEmpty) {
        print("No Object Detected");
      }
      for (DetectedObject object in objects) {
        print("Bounding Box: ${object.boundingBox}");
        print("Tracking ID: ${object.trackingId}");
        if (object.labels.isEmpty) {
          print("No Labels Found");
        }
        for (Label label in object.labels) {
          print("Label: ${label.text}");
          print("Confidence: ${label.confidence}");
          print("Index: ${label.index}");
        }
      }
      print("=======================================");
    } catch (e) {
      print(e.toString());
    }
  }
  void dispose() {
    objectDetector.close();
  }
}
