import 'package:flutter/material.dart';
import 'package:power_state/src/power_state.dart';
import 'package:power_state/src/power_controller.dart';

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
  final _key = DateTime.now().microsecondsSinceEpoch;
  @override
  void initState() {
    super.initState();
    controller = PowerState.find<T>();
    controller.powerNotifier.addListener(_key, () {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    controller.powerNotifier.removeListener(_key);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(controller);
  }
}
