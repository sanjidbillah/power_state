import 'package:flutter/foundation.dart';

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
  final Type notifierType;
  dynamic currentValue;
  dynamic prevValue;
  Object Function()? selector;

  NotifyInfo(
    this.listener,
    this.notifierType, {
    this.currentValue,
    this.prevValue,
    this.selector,
  });
}

class PowerController extends _ListenAble {
  static final Map<dynamic, NotifyInfo> _listeners = {};

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

    for (final entry in _listeners.entries) {
      final value = entry.value;
      if (runtimeType == value.notifierType) {
        if (value.selector == null) {
          value.listener.call();
        } else {
          value.currentValue = value.selector?.call();
          if (value.currentValue != value.prevValue) {
            value.prevValue = value.currentValue;
            value.listener.call();
          }
        }
      }
    }
  }

  get lisenerLength => _listeners.length;
}
