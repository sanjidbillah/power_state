import 'package:power_state/power_state.dart';

class CounterController extends PowerController {
  int selectorValue = 1;
  int count = 1;

  increment() {
    count++;
    notifyListeners();
  }

  update() {
    selectorValue++;
    notifyListeners();
  }
}
