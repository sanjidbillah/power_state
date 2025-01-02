import 'package:example/controller/counter_controller.dart';
import 'package:example/controller/datetime_controller.dart';
import 'package:flutter/material.dart';
import 'package:power_state/power_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  // Create an instance of the CounterController and store it in PowerVault
  final CounterController controller = PowerVault.put(CounterController());

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Example of using a PowerBuilder widget to rebuild the widget tree
            // when the count value changes
            PowerBuilder<CounterController>(
              builder: (countController) {
                return Text(countController.count.toString());
              },
            ),

            // Example of using a PowerSelector widget with a mutable selector
            PowerSelector<CounterController>(
              selector: () => controller.selectorValue,
              builder: (countController) {
                return Text(countController.selectorValue.toString());
              },
            ),

            // Example of using a PowerSelector widget with an immutable selector
            PowerSelector<CounterController>(
              selector: () => 2,
              builder: (countController) {
                return Text(countController.selectorValue.toString());
              },
            ),

            // Buttons to increment the count value and update the widget tree
            ElevatedButton(
              onPressed: () {
                controller.increment();
                controller.update();
              },
              child: const Text("Update widgets"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SecondScreen(),
                  ),
                );
              },
              child: const Text("Push To Another Screen"),
            )
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  // Initialize the CounterController to access its state.
  final CounterController controller = PowerVault.find();
  SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Normal builder
            PowerBuilder<CounterController>(
              builder: (countController) {
                return Text(countController.count.toString());
              },
            ),

            // Selector with mutable object
            PowerSelector<CounterController>(
              selector: () => controller.selectorValue,
              builder: (countController) {
                return Text(countController.selectorValue.toString());
              },
            ),

            ElevatedButton(
              onPressed: () {
                // Update the count.
                controller.increment();
              },
              child: const Text("Update "),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PushToDeleteCheckScreen(),
                  ),
                );
              },
              child: const Text("Push to delete example page"),
            ),
          ],
        ),
      ),
    );
  }
}

class PushToDeleteCheckScreen extends StatefulWidget {
  const PushToDeleteCheckScreen({Key? key}) : super(key: key);

  @override
  State<PushToDeleteCheckScreen> createState() =>
      _PushToDeleteCheckScreenState();
}

class _PushToDeleteCheckScreenState extends State<PushToDeleteCheckScreen> {
  // Declare a new instance of the DateTimeController.
  final DateTimeController controller = PowerVault.put(DateTimeController());

  @override
  void dispose() {
    // Delete the controller instance when the page is popped.
    PowerVault.delete<DateTimeController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete example screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Use a PowerBuilder to update the UI when the state changes.
            PowerBuilder<DateTimeController>(
              builder: (dateTimeController) {
                return Text(dateTimeController.currentDate.toString());
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Update the state of the controller when the button is pressed.
                controller.updateDate(DateTime(1899));
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}