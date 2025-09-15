import 'package:flutter/material.dart';
import 'package:spooky_state/spooky_state.dart';
import 'package:micro_state_example/toggle.dart';

class OldCounter extends SchrodingerBox<int> {
  final CounterState counter;
  OldCounter(this.counter) : super(waveform: 0);

  void old() {
    final x = counter.waveform;
    final y = x + 10;
    print(y);
  }
}

class CounterState extends SchrodingerBox<int> {
  CounterState() : super(waveform: 0);
  void increment() => shift(waveform + 1);
  void decrement() => shift(waveform - 1);
}

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = CounterState();
    print(counter.waveform);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          counter.observe(
            (value) => Text(
              'Quantum Value: ${value ?? 0}',
              style: const TextStyle(fontSize: 28),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Entangle +1'),
                onPressed: counter.increment,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.remove),
                label: const Text('Collapse -1'),
                onPressed: counter.decrement,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(child: QuantumTogglePage()),
        ],
      ),
    );
  }
}
