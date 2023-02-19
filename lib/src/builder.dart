import 'package:flutter/material.dart';
// import 'package:power_state/src/power_state.dart';
// import 'package:power_state/src/power_controller.dart';

import '../power_state.dart';

/// This widget is responsible for building a widget subtree based on the state of a [PowerController] instance.
///
/// It takes a generic type T that must be a subclass of [PowerController] and a builder function builder that takes
/// an instance of T and returns a widget.
///
/// The state of the [PowerController] instance is updated whenever there is a change in the application state,
/// triggering a rebuild of the widget subtree defined by the builder function.
class PowerBuilder<T extends PowerController> extends StatefulWidget {
  /// A builder function that takes an instance of type T and returns a widget subtree.
  final Widget Function(T controller) builder;

  /// Creates a [PowerBuilder] instance.
  ///
  /// The required parameter builder takes a builder function that takes an instance of type T and returns a widget subtree.
  const PowerBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<PowerBuilder<T>> createState() => _State<T>();
}

class _State<T extends PowerController> extends State<PowerBuilder<T>> {
  /// The [PowerController] instance to listen to changes on.
  late T controller;

  /// A unique identifier for this widget instance.
  late final _uniqueKey = identityHashCode(widget);

  @override
  void initState() {
    super.initState();
// Find the [PowerController] instance of type T.
    controller = PowerVault.find<T>();
// Add a listener to the [PowerController] instance with a unique identifier to be notified of changes.
    controller.addListener(_uniqueKey, () {
      if (mounted) _valueChanged();
    });
  }

  /// Rebuilds the widget subtree defined by the builder function when there is a change in the application state.
  void _valueChanged() {
    setState(() {});
  }

  @override
  void dispose() {
// Remove the listener added in initState() to avoid memory leaks.
    controller.removeListener(_uniqueKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// Build the widget subtree defined by the builder function using the [PowerController] instance.
    return widget.builder(controller);
  }
}
