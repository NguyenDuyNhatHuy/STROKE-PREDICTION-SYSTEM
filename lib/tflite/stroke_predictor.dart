import 'package:tflite_flutter/tflite_flutter.dart';

class StrokePredictor {
  late final Interpreter _interpreter;

  StrokePredictor._(this._interpreter);

  static Future<StrokePredictor> create() async {
    final interpreter = await Interpreter.fromAsset('assets/models/stroke_model.tflite');
    return StrokePredictor._(interpreter);
  }

  Future<bool> predict(List<double> input) async {
    final inputTensor = [input]; // [1, 10]
    final outputTensor = List.generate(1, (_) => List.filled(1, 0.0));

    _interpreter.run(inputTensor, outputTensor);

    final double probability = outputTensor[0][0];
    return probability >= 0.5;
  }

  Future<double> predictProbability(List<double> input) async {
    final inputTensor = [input];
    final outputTensor = List.generate(1, (_) => List.filled(1, 0.0));
    _interpreter.run(inputTensor, outputTensor);
    return outputTensor[0][0];
  }

  void close() {
    _interpreter.close();
  }
}
