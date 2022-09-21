import 'package:flutter/material.dart';
import 'package:power_state/power_state.dart';

import '../controller/test_controller.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: PowerBuilder<TestController>(
          builder: (testController) => Text(
            testController.counter.toString(),
          ),
        ),
      ),
    );
  }
}
