import 'package:flutter/material.dart';

import '../power_state.dart';

class PowerSelector<T extends PowerController> extends StatefulWidget {
  final Widget Function(T controller) builder;
  final Object Function() selector;

  const PowerSelector({
    Key? key,
    required this.builder,
    required this.selector,
  }) : super(key: key);

  @override
  State<PowerSelector<T>> createState() => _State<T>();
}

class _State<T extends PowerController> extends State<PowerSelector<T>> {
  late T controller;
  late final _uniqueKey = identityHashCode(widget);
  @override
  void initState() {
    super.initState();
    controller = PowerVault.find<T>();
    controller.powerNotifier.addListener(_uniqueKey, () {
      if (mounted) setState(() {});
    });
    controller.powerNotifier.selector(_uniqueKey, widget.selector);
  }

  @override
  void dispose() {
    controller.powerNotifier.removeListener(_uniqueKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(controller);
  }
}
