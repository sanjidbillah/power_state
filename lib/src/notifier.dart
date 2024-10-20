import 'package:flutter/foundation.dart';

abstract class _ListenAble {
  /// Register a closure to be called when the object notifies its listeners.
  void addListener(int key, VoidCallback listener);

  /// Register a closure to be called when the object notifies its listeners.
  void addSelector(int key, Function dependency);

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

class PowerController extends _ListenAble {
  static final Map _listeners = {};
  static final Map _selectors = {};
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

  @override
  addSelector(int key, Function dependency) {
    dynamic value = dependency.call();
    _selectors[key] = {
      'currentValue': value,
      'prevValue': value,
      'selector': dependency,
    };
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
    _listeners.forEach(
      (key, value) {
        !_selectors.containsKey(key)
            ? value.call()
            : _selectorNotify(key, value);
      },
    );
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

  _selectorNotify(key, dynamic state) {
    final v = _selectors[key];
    v['currentValue'] = v['selector'].call();

    if (v['currentValue'] != v['prevValue']) {
      v['prevValue'] = v['currentValue'];
      state.call();
    }
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
