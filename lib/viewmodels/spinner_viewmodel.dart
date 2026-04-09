import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/spinner_model.dart';

class SpinnerViewModel extends ChangeNotifier {
  final SpinnerModel model;
  late AnimationController animationController;

  SpinnerViewModel({required this.model});

  void initAnimation(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 800),
    )..repeat();
  }

  double calcRotation(int index, double controllerValue) {
    final animationRotationValue =
        controllerValue * 2 * math.pi / model.numberOfTexts;
    double rotation = 2 * math.pi * index / model.numberOfTexts +
        math.pi / 2 +
        animationRotationValue;
    if (math.cos(rotation) > 0) {
      rotation = -rotation +
          2 * animationRotationValue -
          math.pi * 2 / model.numberOfTexts;
    }
    return rotation;
  }

  void disposeAnimation() {
    animationController.dispose();
  }
}
