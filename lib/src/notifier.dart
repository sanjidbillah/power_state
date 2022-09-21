import 'package:flutter/foundation.dart';

class PowerNotifier {
  final Map _listeners = {};

  void addListener(int key, VoidCallback listener) {
    _listeners[key] = listener;
    print('add listener ${_listeners}');
  }

  void removeListener(int key) {
    _listeners.remove(key);
  }

  void notify() {
    if (_listeners.isEmpty) return;
    _listeners.forEach((k, v) => v());
  }

  get lisenerLength => _listeners.length;
}
