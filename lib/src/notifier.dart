import 'package:flutter/foundation.dart';
import 'package:power_state/src/utilities/printer.dart';

abstract class _ListenAble {
  /// Register a closure to be called when the object notifies its listeners.
  void addListener(int key, NotifyInfo notifyInfo);

  /// Remove a previously registered closure from the list of closures that the
  /// object notifies.
  void removeListener(int key);

  /// Call all the registered listeners.
  ///
  /// Call this method whenever the object changes, to notify any clients the
  /// object may have changed. Listeners that are added during this iteration
  /// will not be visited. Listeners that are removed during this iteration will
  /// not be visited after they are removed.
  void notifyListeners();
}

class NotifyInfo {
  final VoidCallback listener;
  final Type notifierName;

  NotifyInfo(
    this.listener,
    this.notifierName,
  );
}

class PowerController extends _ListenAble {
  static final Map<dynamic, NotifyInfo> _listeners = {};
  bool _debugDisposed = false;
  @override
  void addListener(int key, NotifyInfo notifyInfo) {
    _listeners[key] = notifyInfo;
  }

  @override
  void removeListener(int key) {
    _listeners.remove(key);
  }

  /// Call all the registered listeners.
  ///
  /// Call this method whenever the object changes, to notify any clients the
  /// object may have changed. Listeners that are added during this iteration
  /// will not be visited. Listeners that are removed during this iteration will
  /// not be visited after they are removed.
  @override
  void notifyListeners() {
    if (_listeners.isEmpty) return;
    int rebuildCount = 0;
    for (final entry in _listeners.entries) {
      final value = entry.value;

      if (runtimeType == value.notifierName) {
        rebuildCount++;
        printer("Count Rebuild: $rebuildCount");
        value.listener.call();
      }
    }
  }

  // This is static and not an instance method because too many people try to
  // implement ChangeNotifier instead of extending it (and so it is too breaking
  // to add a method, especially for debug).
  static bool debugAssertNotDisposed(PowerController notifier) {
    assert(() {
      if (notifier._debugDisposed) {
        throw Exception(
          'A ${notifier.runtimeType} was used after being disposed.\n'
          'Once you have called dispose() on a ${notifier.runtimeType}, it '
          'can no longer be used.',
        );
      }
      return true;
    }());
    return true;
  }

  dispose() {
    assert(PowerController.debugAssertNotDisposed(this));
    assert(() {
      _debugDisposed = true;
      return true;
    }());
    _listeners.clear();
  }

  get lisenerLength => _listeners.length;
}
