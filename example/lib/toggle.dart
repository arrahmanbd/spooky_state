import 'package:flutter/material.dart';
import 'package:spooky_state/spooky_state.dart';

class ToggleLogic {
  late SchrodingerBox<bool> toggleWaveform;

  ToggleLogic() {
    toggleWaveform = SchrodingerBox<bool>(waveform: false);
  }

  void toggle() {
    toggleWaveform.shift(!toggleWaveform.waveform!);
  }

  void dispose() {
    toggleWaveform.collapse();
  }
}

class QuantumTogglePage extends StatelessWidget {
  final ToggleLogic toggleLogic = ToggleLogic();

  QuantumTogglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Simple value observation
          toggleLogic.toggleWaveform.observe(
            (value) => Text(value! ? 'ON' : 'OFF'),
          ),
          // WavefunctionObserver<bool>(
          //   waveform: toggleLogic.toggleWaveform,
          //   builder: (context, value) => Text(
          //     value! ? 'ON' : 'OFF',
          //     style: const TextStyle(fontSize: 32),
          //   ),
          // ),

          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: toggleLogic.toggle,
            child: const Text('Toggle'),
          ),
        ],
      ),
    );
  }
}
