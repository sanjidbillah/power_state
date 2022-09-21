import 'package:power_state/power_state.dart';

class TestController extends PowerController {
  int _counter = 1;

  int get counter => _counter;

  void increment([int? value]) {
    _counter++;
    notifyListeners();
  }
}
