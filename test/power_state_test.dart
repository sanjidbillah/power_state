import 'package:flutter_test/flutter_test.dart';
import 'package:power_state/power_state.dart';

import 'controller/test_controller.dart';
import 'widgets/test_widgets.dart';

void main() {
  testWidgets(
    'Widgets update when the model notifies the listeners',
    (WidgetTester tester) async {
      final TestController controller = PowerState.put(TestController());
      // Starts out at the initial value
      await tester.pumpWidget(const TestWidget());
      await tester.pumpAndSettle();

      // Call Increment which should notify the children to rebuild
      controller.increment();
      await tester.pumpWidget(const TestWidget());
      expect(controller.powerNotifier.lisenerLength, 1);
      expect(find.text('2'), findsOneWidget);
    },
  );
}
