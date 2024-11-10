import 'package:power_state/src/utilities/printer.dart';

/// The `PowerVault` class provides a way to store and retrieve dependencies
/// (such as controllers or services) as singletons, allowing shared instances
/// across an application.
///
/// Example usage:
/// ```
/// PowerVault.put<MyController>(MyController());
/// final controller = PowerVault.find<MyController>();
/// ```
class PowerVault {
  // A singleton instance of `_Instance` which manages the dependency storage.
  static final _Instance __instance = _Instance();

  /// Adds a dependency of type `T` to the store.
  /// If a dependency of type `T` already exists, it will not be replaced.
  ///
  /// - Parameter `dependency`: The instance of type `T` to be stored.
  /// - Returns: The instance of the dependency that was added or previously
  /// existing.
  static T put<T>(T dependency) => __instance.put<T>(dependency);

  /// Finds and returns an existing dependency of type `T` from the store.
  ///
  /// - Returns: The stored instance of type `T`.
  /// - Throws: An `Exception` if the dependency is not found.
  static T find<T>() => __instance.find<T>();

  /// Deletes an existing dependency of type `T` from the store.
  ///
  /// - Returns: `true` if the dependency was successfully deleted;
  ///   `false` if it was not found.
  static bool delete<T>() => __instance.delete<T>();

  /// Clears all stored dependencies from the store.
  static clear() => __instance.clear();
}

/// Internal class `_Instance` responsible for managing the actual store of
/// dependencies. This class follows a singleton pattern to ensure a single
/// source of dependency management.
class _Instance {
  // Factory constructor that returns the singleton instance of `_Instance`.
  factory _Instance() => _instance ??= _Instance._();

  // The singleton instance of `_Instance`.
  static _Instance? _instance;

  // Private constructor to prevent external instantiation.
  _Instance._();

  // A map that stores dependencies by their type's string representation.
  static final Map<String, _InstanceModel> _store = {};

  /// Adds a dependency of type `T` to the store.
  ///
  /// - Parameter `dependency`: The instance of type `T` to store.
  /// - Returns: The instance of the dependency that was added or previously
  /// existing.
  T put<T>(T dependency) {
    _store.putIfAbsent(T.toString(), () => _InstanceModel<T>(dependency));
    printer('🎯 ${T.toString()} controller initiated.');
    return find<T>();
  }

  /// Finds and returns a dependency of type `T` from the store.
  ///
  /// - Returns: The instance of type `T` if it exists.
  /// - Throws: An `Exception` if the dependency is not found.
  T find<T>() {
    var info = _store[T.toString()];

    if (info?.value != null) {
      return info!.value;
    } else {
      throw Exception('$T controller not found.');
    }
  }

  /// Deletes a dependency of type `T` from the store.
  ///
  /// - Returns: `true` if the dependency was successfully deleted;
  ///   `false` if it was not found.
  bool delete<T>() {
    final controller = T.toString();
    if (!_store.containsKey(controller)) {
      printer('💥 $controller controller already removed.');
      return false;
    }
    _store.remove(controller);
    printer('🔥 $controller controller deleted.');
    return true;
  }

  /// Clears all dependencies from the store.
  void clear() {
    _store.clear();
    printer('🔥🔥🔥 All controllers deleted.');
  }
}

/// Represents the model for a stored dependency instance.
/// Stores the value of type `T`.
class _InstanceModel<T> {
  // Constructor that initializes the value of type `T`.
  _InstanceModel(this.value);

  // The stored dependency instance of type `T`.
  T value;
}
