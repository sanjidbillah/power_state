import 'package:example/controller/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:power_state/power_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CounterController controller = PowerVault.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PowerBuilder<CounterController>(
              builder: (countController) {
                return Text(countController.number.toString());
              },
            ),
            ElevatedButton(
              onPressed: () {
                controller.increment();
              },
              child: const Text("Increment"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SecondScreen(),
                  ),
                );
              },
              child: const Text("Push Another Screen"),
            )
          ],
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

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
                return Text(countController.number.toString());
              },
            ),
            PowerBuilder<CounterController>(
              builder: (countController) {
                return Text(countController.number.toString());
              },
            ),
          ],
        ),
      ),
    );
  }
}
