import 'package:power_state/src/utilities/printer.dart';

class PowerVault {
  static T put<T>(T dependency) => _Instance().put<T>(dependency);

  static T find<T>() => _Instance().find<T>();

  static bool delete<T>() => _Instance().delete<T>();
}

class _Instance {
  factory _Instance() => _instance ??= _Instance._();

  static _Instance? _instance;

  _Instance._();

  static final Map<String, _InstanceModel> _store = {};

  T put<T>(T dependency) {
    _store.putIfAbsent(T.toString(), () => _InstanceModel<T>(dependency));
    return find<T>();
  }

  T find<T>() {
    var info = _store[T.toString()];

    if (info?.value != null) {
      return info!.value;
    } else {
      throw Exception('$T controller not found.');
    }
  }

  bool delete<T>() {
    final controller = T.toString();
    if (!_store.containsKey(controller)) {
      printer('$controller controller already removed.');
      return false;
    }
    _store.remove(controller);
    printer('$controller controller deleted.');
    return true;
  }
}

class _InstanceModel<T> {
  _InstanceModel(this.value);

  T value;
}
