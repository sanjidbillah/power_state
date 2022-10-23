import 'package:flutter/material.dart';
// import 'package:power_state/src/power_state.dart';
// import 'package:power_state/src/power_controller.dart';

import '../power_state.dart';

class PowerBuilder<T extends PowerController> extends StatefulWidget {
  final Widget Function(T controller) builder;
  const PowerBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<PowerBuilder<T>> createState() => _State<T>();
}

class _State<T extends PowerController> extends State<PowerBuilder<T>> {
  late T controller;
  late final _uniqueKey = identityHashCode(widget);
  @override
  void initState() {
    super.initState();
    controller = PowerVault.find<T>();
    controller.addListener(_uniqueKey, () {
      if (mounted) _valueChanged();
    });
  }

  void _valueChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    controller.removeListener(_uniqueKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(controller);
  }
}
