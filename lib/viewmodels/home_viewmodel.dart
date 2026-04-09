import 'package:flutter/material.dart';
import '../models/spinner_model.dart';

class HomeViewModel extends ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  bool _showTorch = false;

  bool get showTorch => _showTorch;

  SpinnerModel get model => SpinnerModel(text: textController.text);

  bool get canNavigate => model.isValid;

  void toggleTorch() {
    _showTorch = !_showTorch;
    notifyListeners();
  }

  void onTextChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
