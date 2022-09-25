import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:power_state/power_state.dart';

import 'controller/test_controller.dart';

void main() {
  testWidgets(
    'Widgets update when the model notifies the listeners',
    (WidgetTester tester) async {
      final TestController controller = PowerVault.put(TestController());
      // Starts out at the initial value
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: PowerBuilder<TestController>(builder: (testController) {
              return Column(
                children: [
                  Text(
                    testController.counter.toString(),
                  ),
                ],
              );
            }),
          ),
        ),
      );

      // Call Increment which should notify the children to rebuild
      controller.increment();

      await tester.pumpAndSettle();

      expect(find.text('2'), findsOneWidget);
      PowerVault.delete<TestController>();
    },
  );

  testWidgets(
    'Selector rebuild check with fixed value',
    (WidgetTester tester) async {
      final TestController controller = PowerVault.put(TestController());
      // Starts out at the initial value
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: PowerSelector<TestController>(
            selector: () => 2,
            builder: (testController) => Text(
              testController.selectorValue.toString(),
            ),
          ),
        ),
      ));

      // Call Increment which should notify the children to rebuild
      controller.updateSelctorValue();

      expect(find.text('1'), findsOneWidget);
      PowerVault.delete<TestController>();
    },
  );

  testWidgets(
    'Selector rebuild check with dynamic value',
    (WidgetTester tester) async {
      final TestController controller = PowerVault.put(TestController());
      // Starts out at the initial value
      await tester.pumpWidget(MaterialApp(
        home: Material(
          child: PowerSelector<TestController>(
            selector: () => controller.selectorValue,
            builder: (testController) => Text(
              testController.selectorValue.toString(),
            ),
          ),
        ),
      ));

      // Call Increment which should notify the children to rebuild
      controller.updateSelctorValue();

      expect(find.text('1'), findsOneWidget);
      PowerVault.delete<TestController>();
    },
  );

  test('Controller lifeCycle', () {
    final TestController controller = PowerVault.put(TestController());
    expect(controller.counter, 1);
    controller.increment();
    expect(controller.counter, 2);
    final TestController controller2 = PowerVault.put(TestController());
    expect(controller2.counter, 2);
    PowerVault.delete<TestController>();
    final TestController controller3 =
        PowerVault.put<TestController>(TestController());
    expect(controller3.counter, 1);
    PowerVault.delete<TestController>();
  });
}
