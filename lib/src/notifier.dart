import 'package:flutter/foundation.dart';

abstract class _ListenAble {
  /// Register a closure to be called when the object notifies its listeners.
  void addListener(int key, VoidCallback listener);

  /// Remove a previously registered closure from the list of closures that the
  /// object notifies.
  void removeListener(int key);

  /// Call all the registered listeners.
  ///
  /// Call this method whenever the object changes, to notify any clients the
  /// object may have changed. Listeners that are added during this iteration
  /// will not be visited. Listeners that are removed during this iteration will
  /// not be visited after they are removed.
  void notify();
}

class PowerNotifier extends _ListenAble {
  final Map _listeners = {};

  @override
  void addListener(int key, VoidCallback listener) {
    _listeners[key] = listener;
  }

  @override
  void removeListener(int key) {
    _listeners.remove(key);
  }

  @override
  void notify() {
    if (_listeners.isEmpty) return;
    _listeners.forEach((k, v) => v());
  }

  get lisenerLength => _listeners.length;
}
