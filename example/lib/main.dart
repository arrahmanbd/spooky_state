import 'package:flutter/material.dart';
import 'package:micro_state_example/counter.dart';
import 'driving.dart';

void main() {
  runApp(const MyQuantumApp());
}

class MyQuantumApp extends StatelessWidget {
  const MyQuantumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quantum Counter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quantum Home')),
      body: const CounterPage(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.drive_eta),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const QuantumDrivingPage()),
          );
        },
      ),
    );
  }
}
