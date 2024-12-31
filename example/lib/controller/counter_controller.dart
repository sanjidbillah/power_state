import 'package:power_state/power_state.dart';

class CounterController extends PowerController {
  // The value selected by the selector
  int selectorValue = 1;
  // The count of the counter
  int count = 1;

  // Increment the count and notify listeners
  increment() {
    count++;
    notifyListeners();
  }

  // Update the selector value and notify listeners
  update() {
    selectorValue++;
    notifyListeners();
  }
}

class CounterController2 extends PowerController {
  // The value selected by the selector
  int selectorValue = 1;
  // The count of the counter
  int count = 1;

  // Increment the count and notify listeners
  increment() {
    count++;
    notifyListeners();
  }

  // Update the selector value and notify listeners
  update() {
    selectorValue++;
    notifyListeners();
  }
}
