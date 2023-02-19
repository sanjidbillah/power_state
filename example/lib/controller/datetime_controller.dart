import 'package:power_state/power_state.dart';

class DateTimeController extends PowerController {
  // The current date managed by the controller
  DateTime _currentDate = DateTime.now();

  // Get the current date
  DateTime get currentDate => _currentDate;

  // Update the current date to a custom date and notify listeners
  updateDate(DateTime customDate) {
    _currentDate = customDate;
    notifyListeners();
  }
}
