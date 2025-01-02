import 'package:flutter/material.dart';

import '../power_state.dart';

// A widget that listens to changes in a PowerController and rebuilds itself accordingly.
class PowerSelector<T extends PowerController> extends StatefulWidget {
  // A function that takes a controller of type T and returns a widget to be built.
  final Widget Function(T controller) builder;
  // A function that returns an object used to determine whether this widget should rebuild.
  final Object Function() selector;

  const PowerSelector({
    Key? key,
    required this.builder,
    required this.selector,
  }) : super(key: key);

  @override
  State<PowerSelector<T>> createState() => _State<T>();
}

// The state class for the PowerSelector widget.
class _State<T extends PowerController> extends State<PowerSelector<T>> {
  // The controller instance to listen to.
  late T controller;
  // A unique key used to identify this widget instance.
  late final _uniqueKey = identityHashCode(widget);

  @override
  void initState() {
    super.initState();
    // Find the controller instance from the PowerVault.
    controller = PowerVault.find<T>();
    // Add this widget instance as a listener to the controller.
    controller.addListener(
      _uniqueKey,
      NotifyInfo(
        _valueChanged,
        controller.runtimeType,
        selector: widget.selector,
      ),
    );
  }

  // Called when the value of the controller changes.
  void _valueChanged() {
    // Rebuild the widget.
    setState(() {});
  }

  @override
  void dispose() {
    // Remove this widget instance as a listener from the controller.
    controller.removeListener(_uniqueKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Call the builder function with the controller instance.
    return widget.builder(controller);
  }
}
