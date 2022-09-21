import 'notifier.dart';

class PowerController {
  PowerNotifier powerNotifier = PowerNotifier();

  void notifyListeners() {
    powerNotifier.notify();
  }
}
