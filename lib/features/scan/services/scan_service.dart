import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:scrape_application/features/scan/models/scan_model.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ScanService {
  late Interpreter interpreter;
  List<String> labels = [];

  Future<void> loadModel() async {
    debugPrint("Load Model Called");
    interpreter = await Interpreter.fromAsset(
      'assets/ml/metal_classifier.tflite',
    );

    final labelData = await rootBundle.loadString('assets/ml/labels.txt');

    labels = labelData.split('\n').where((e) => e.trim().isNotEmpty).toList();
  }

  Future<Map<String, dynamic>> predictImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) {
      throw Exception("Unable to decode image");
    }
    final resized = img.copyResize(image, width: 224, height: 224);
    final input = List.generate(
      1,
      (_) => List.generate(
        224,
        (y) => List.generate(224, (x) {
          final pixel = resized.getPixel(x, y);
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        }),
      ),
    );

    final output = List.generate(1, (_) => List.filled(labels.length, 0.0));
    interpreter.run(input, output);
    final scores = output.first;
    int bestIndex = 0;
    double bestScore = scores[0];

    for (int i = 1; i < scores.length; i++) {
      if (scores[i] > bestScore) {
        bestScore = scores[i];
        bestIndex = i;
      }
    }
    return {"label": labels[bestIndex], "confidence": bestScore};
  }
}
