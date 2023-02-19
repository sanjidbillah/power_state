import 'package:power_state/src/utilities/printer.dart';

// This class provides a way to store and retrieve dependencies (such as controllers or services) as singletons.
class PowerVault {
  // Puts a dependency of type T into the store.
  // Returns the instance of the dependency that was added.
  static T put<T>(T dependency) => _Instance().put<T>(dependency);

  // Finds and returns a dependency of type T from the store.
  // Throws an Exception if the dependency is not found.
  static T find<T>() => _Instance().find<T>();

  // Deletes a dependency of type T from the store.
  // Returns true if the dependency was successfully deleted, false if it was not found.
  static bool delete<T>() => _Instance().delete<T>();
}

// This class is responsible for managing the actual store of dependencies.
class _Instance {
  // Creates a singleton instance of the _Instance class.
  factory _Instance() => _instance ??= _Instance._();

  // The singleton instance of the _Instance class.
  static _Instance? _instance;

  // Private constructor to prevent the creation of multiple instances.
  _Instance._();

  // The map that stores the dependencies.
  static final Map<String, _InstanceModel> _store = {};

  // Adds a dependency of type T to the store.
  // Returns the instance of the dependency that was added.
  T put<T>(T dependency) {
    _store.putIfAbsent(T.toString(), () => _InstanceModel<T>(dependency));
    return find<T>();
  }

  // Finds and returns a dependency of type T from the store.
  // Throws an Exception if the dependency is not found.
  T find<T>() {
    var info = _store[T.toString()];

    if (info?.value != null) {
      return info!.value;
    } else {
      throw Exception('$T controller not found.');
    }
  }

  // Deletes a dependency of type T from the store.
  // Returns true if the dependency was successfully deleted, false if it was not found.
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

// This class represents the model for a dependency instance.
class _InstanceModel<T> {
  // Constructor that takes a value of type T.
  _InstanceModel(this.value);

  // The value of the dependency instance.
  T value;
}
