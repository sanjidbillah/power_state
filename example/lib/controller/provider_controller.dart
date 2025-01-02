import 'package:flutter/material.dart';

class ProviderController1 with ChangeNotifier {
  int currentValue = 1;

  update() {
    currentValue++;
    notifyListeners();
  }
}

class ProviderController2 with ChangeNotifier {
  int currentValue = 1;

  update() {
    currentValue++;
    notifyListeners();
  }
}
