import 'package:power_state/power_state.dart';

class TestController extends PowerController {
  int _counter = 1;
  int _selectorValue = 1;

  int get counter => _counter;
  int get selectorValue => _selectorValue;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void updateSelctorValue() {
    _selectorValue++;
    notifyListeners();
  }
}
