// This imports the power_state library which provides the PowerController class
import 'package:power_state/power_state.dart';

// This defines a custom TestController class that extends the PowerController class
class TestController extends PowerController {
// These are private member variables for the TestController class
  int _counter = 1;
  int _selectorValue = 1;

// These are getter methods for the private member variables
  int get counter => _counter;
  int get selectorValue => _selectorValue;

// This method increments the counter and notifies listeners of the change
  void increment() {
    _counter++;
    notifyListeners();
  }

// This method updates the selector value and notifies listeners of the change
  void updateSelctorValue() {
    _selectorValue++;
    notifyListeners();
  }
}


// This defines a custom TestController class that extends the PowerController class
class TestController2 extends PowerController {
// These are private member variables for the TestController class
  int _counter = 1;
  int _selectorValue = 1;

// These are getter methods for the private member variables
  int get counter => _counter;
  int get selectorValue => _selectorValue;

// This method increments the counter and notifies listeners of the change
  void increment() {
    _counter++;
    notifyListeners();
  }

// This method updates the selector value and notifies listeners of the change
  void updateSelctorValue() {
    _selectorValue++;
    notifyListeners();
  }
}


// This defines a custom TestController class that extends the PowerController class
class TestController3 extends PowerController {
// These are private member variables for the TestController class
  int _counter = 1;
  int _selectorValue = 1;

// These are getter methods for the private member variables
  int get counter => _counter;
  int get selectorValue => _selectorValue;

// This method increments the counter and notifies listeners of the change
  void increment() {
    _counter++;
    notifyListeners();
  }

// This method updates the selector value and notifies listeners of the change
  void updateSelctorValue() {
    _selectorValue++;
    notifyListeners();
  }
}
