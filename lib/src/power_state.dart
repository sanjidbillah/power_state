class PowerState {
  static T put<T>(T dependency) => _Instance().put(dependency);

  static T find<T>() => _Instance().find<T>();

  static bool delete<T>() => _Instance().delete<T>();
}

class _Instance {
  factory _Instance() => _instance ??= _Instance._();

  static _Instance? _instance;

  _Instance._();

  static final Map<String, _InstanceModel> _store = {};

  T put<T>(
    T dependency,
  ) {
    _store.putIfAbsent(T.toString(), () => _InstanceModel<T>(dependency));
    return find<T>();
  }

  T find<T>() {
    var info = _store[T.toString()];

    if (info?.value != null) {
      return info!.value;
    } else {
      throw '$T"controller not found.';
    }
  }

  bool delete<T>() {
    final newKey = T.toString();
    if (!_store.containsKey(newKey)) {
      print('$newKey controller already removed.');
      return false;
    }

    _store.remove(newKey);
    print('$newKey controller deleted.');
    return true;
  }
}

class _InstanceModel<T> {
  _InstanceModel(this.value);

  T value;
}
