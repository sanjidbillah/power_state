import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:power_state/power_state.dart';

import 'controller/test_controller.dart';

void main() {
  testWidgets(
    'Widgets update when the model notifies the listeners',
    (WidgetTester tester) async {
      // Create an instance of TestController and add it to PowerVault
      final TestController controller = PowerVault.put(TestController());

      // Build a widget tree that uses PowerBuilder to listen to changes in the controller's state
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

      // Call increment on the controller, which should notify the PowerBuilder to rebuild its child widgets
      controller.increment();

      await tester.pumpAndSettle();

      // Expect to find the new value of the counter in the widget tree
      expect(find.text('2'), findsOneWidget);

      // Remove the controller instance from PowerVault
      PowerVault.delete<TestController>();
    },
  );

  test('Controller lifeCycle', () {
    // Create an instance of TestController and add it to PowerVault
    final TestController controller = PowerVault.put(TestController());

    // Expect the initial value of the controller's state
    expect(controller.counter, 1);

    // Call increment on the controller and expect the new value of the counter
    controller.increment();
    expect(controller.counter, 2);

    // Create another instance of TestController and expect it to have the same state as the previous instance
    final TestController controller2 = PowerVault.put(TestController());
    expect(controller2.counter, 2);

    // Remove the first instance of TestController from PowerVault
    PowerVault.delete<TestController>();

    // Create a new instance of TestController and expect its state to be reset
    final TestController controller3 = PowerVault.put<TestController>(TestController());
    expect(controller3.counter, 1);

    // Remove the second instance of TestController from PowerVault
    PowerVault.delete<TestController>();
  });
}
