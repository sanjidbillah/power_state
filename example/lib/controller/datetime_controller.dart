import 'package:power_state/power_state.dart';

class DateTimeController extends PowerController {
  DateTime _currentDate = DateTime.now();
  DateTime get currentDate => _currentDate;
  updateDate(DateTime customDate) {
    _currentDate = customDate;
    notifyListeners();
  }
}
