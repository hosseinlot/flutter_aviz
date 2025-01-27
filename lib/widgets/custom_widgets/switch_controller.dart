import 'package:flutter/material.dart';

class SwitchController extends ChangeNotifier {
  SwitchController({required this.switchValue});

  bool switchValue = false;

  void toggleSwitch() {
    switchValue = !switchValue;
    notifyListeners();
  }
}
