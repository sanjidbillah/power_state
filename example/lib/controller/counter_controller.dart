import 'package:power_state/power_state.dart';

class CounterController extends PowerController {
  int number = 1;

  increment() {
    number++;
    notifyListeners();
  }
}
