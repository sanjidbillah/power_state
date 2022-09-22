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
  final Map _selectors = {};
  bool _debugDisposed = false;
  @override
  void addListener(int key, VoidCallback listener) {
    _listeners[key] = listener;
  }

  @override
  void removeListener(int key) {
    _listeners.remove(key);
    _selectors.remove(key);
  }

  selector(int key, Function dependency) {
    int value = dependency.call();
    _selectors.putIfAbsent(
      key,
      () => {'currentValue': value, 'prevValue': value, 'selector': dependency},
    );
  }

  /// Call all the registered listeners.
  ///
  /// Call this method whenever the object changes, to notify any clients the
  /// object may have changed. Listeners that are added during this iteration
  /// will not be visited. Listeners that are removed during this iteration will
  /// not be visited after they are removed.
  @override
  void notify() {
    if (_listeners.isEmpty) return;
    _listeners.forEach(
      (key, value) {
        !_selectors.containsKey(key) ? value.call() : _selectorNotify(value);
      },
    );
  }

  // This is static and not an instance method because too many people try to
  // implement ChangeNotifier instead of extending it (and so it is too breaking
  // to add a method, especially for debug).
  static bool debugAssertNotDisposed(PowerNotifier notifier) {
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

  _selectorNotify(dynamic state) {
    _selectors.forEach(
      (k, v) {
        v['currentValue'] = v['selector'].call();

        if (v['currentValue'] != v['prevValue']) {
          v['prevValue'] = v['currentValue'];
          state.call();
          return;
        } else {
          return;
        }
      },
    );
  }

  dispose() {
    assert(PowerNotifier.debugAssertNotDisposed(this));
    assert(() {
      _debugDisposed = true;
      return true;
    }());
    _listeners.clear();
  }

  get lisenerLength => _listeners.length;
}
