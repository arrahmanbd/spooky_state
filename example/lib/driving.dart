import 'package:flutter/material.dart';
import 'package:spooky_state/spooky_state.dart';

class DrivingLogic {
  late SchrodingerBox<int> age;
  late SchrodingerBox<bool> canDrive;

  DrivingLogic() {
    age = SchrodingerBox<int>();
    canDrive = SchrodingerBox<bool>(waveform: false);

    // Entangle age updates with eligibility logic
    age.entangle(age, (box) {
      final years = box.waveform;
      if (years != null) {
        canDrive.shift(years >= 18);
      }
    });
  }

  void dispose() {
    age.collapse();
    canDrive.collapse();
  }
}

class QuantumDrivingPage extends StatefulWidget {
  const QuantumDrivingPage({super.key});

  @override
  State<QuantumDrivingPage> createState() => _QuantumDrivingPageState();
}

class _QuantumDrivingPageState extends State<QuantumDrivingPage> {
  final logic = DrivingLogic();
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter your age',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  final age = int.tryParse(value);
                  if (age != null) {
                    logic.age.shift(age);
                  }
                },
              ),
              const SizedBox(height: 20),

              // Observe if they can drive
              logic.canDrive.observe(
                (canDrive) => Text(
                  canDrive == true
                      ? '🚗 You can drive!'
                      : '🚫 Not eligible to drive.',
                  style: TextStyle(
                    fontSize: 24,
                    color: canDrive == true ? Colors.green : Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
