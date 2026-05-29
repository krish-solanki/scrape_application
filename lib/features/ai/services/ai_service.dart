import 'package:tflite_flutter/tflite_flutter.dart';

class AIService {
  static final AIService instance = AIService._();

  AIService._();

  Interpreter? interpreter;

  Future<void> loadModel() async {
    interpreter = await Interpreter.fromAsset(
      'assets/ml/metal_classifier.tflite',
    );
  }
}