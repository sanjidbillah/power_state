import 'package:example/controller/counter_controller.dart';
import 'package:example/controller/datetime_controller.dart';
import 'package:flutter/material.dart';
import 'package:power_state/power_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  // Put your controlller
  final CounterController controller = PowerVault.put(CounterController());

  Home({super.key});

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

            // Selector with immutable object
            PowerSelector<CounterController>(
              selector: () => 2,
              builder: (countController) {
                return Text(countController.selectorValue.toString());
              },
            ),
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
  final CounterController controller = PowerVault.find();
  SecondScreen({super.key});

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
            PowerBuilder<CounterController>(
              builder: (countController) {
                return Text(countController.count.toString());
              },
            ),
            PowerSelector<CounterController>(
              selector: () => controller.selectorValue,
              builder: (countController) {
                return Text(countController.selectorValue.toString());
              },
            ),
            ElevatedButton(
              onPressed: () {
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
  const PushToDeleteCheckScreen({super.key});

  @override
  State<PushToDeleteCheckScreen> createState() =>
      _PushToDeleteCheckScreenState();
}

class _PushToDeleteCheckScreenState extends State<PushToDeleteCheckScreen> {
  final DateTimeController controller = PowerVault.put(DateTimeController());

  @override
  void dispose() {
    // When page pop controller will delete
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
            PowerBuilder<DateTimeController>(
              builder: (dateTimeController) {
                return Text(dateTimeController.currentDate.toString());
              },
            ),
            ElevatedButton(
                onPressed: () {
                  controller.updateDate(DateTime(1899));
                },
                child: const Text("Update")),
          ],
        ),
      ),
    );
  }
}
