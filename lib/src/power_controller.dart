import 'notifier.dart';

class PowerController {
  PowerNotifier powerNotifier = PowerNotifier();

  /// Call this method whenever the object changes, to notify any clients the
  /// object may have changed. Listeners that are added during this iteration
  /// will not be visited. Listeners that are removed during this iteration will
  /// not be visited after they are removed.
  void notifyListeners() {
    powerNotifier.notify();
  }
}
