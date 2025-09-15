import 'package:flutter/material.dart';
import 'package:spooky_state/spooky_state.dart';

class ToggleLogic extends SchrodingerBox<bool> {
  ToggleLogic({required super.waveform});
  void toggle() {
    shift(!waveform);
  }
}

class QuantumTogglePage extends StatelessWidget {
  const QuantumTogglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return QuantumWidget<bool, ToggleLogic>(
      create: () => ToggleLogic(waveform: false),
      middleware: [
        (current, next) {
          print('Middleware: $current -> $next');
          return next;
        },
      ],
      builder: (context, value, toggleLogic) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value ? 'ON' : 'OFF',
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: toggleLogic.toggle,
                child: const Text('Toggle'),
              ),
            ],
          ),
        );
      },
    );
  }
}

///Middleware example
// final toggleBox = SchrodingerBox<bool>(waveform: false);

// toggleBox.use((current, next) {
//   print('Middleware: $current -> $next');
//   return next; // allow
// });

// toggleBox.use((current, next) {
//   if (next == true) return null; // cancel turning ON
//   return next;
// });

// toggleBox.shift(true); // Will be cancelled by second middleware
// toggleBox.shift(false); // Will succeed

class QuantumTogglePage2 extends StatelessWidget {
  const QuantumTogglePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return LogicProvider<bool, ToggleLogic>(
      create: () => ToggleLogic(waveform: false),
      middleware: [
        (current, next) {
          print('Middleware: $current -> $next');
          return next; // allow all changes
        },
        // (current, next) {
        //   if (next == true) {
        //     print('Middleware: Prevent turning ON');
        //     return null; // cancel turning ON
        //   }
        //   return next;
        // }
      ],
      builder: (context, toggleLogic) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WavefunctionObserver<bool>(
                waveform: toggleLogic, // observe the logic directly
                builder: (context, value) => Text(value ? 'ON' : 'OFF',
                    style: const TextStyle(fontSize: 32)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: toggleLogic.toggle, // fully accessible
                child: const Text('Toggle'),
              ),
            ],
          ),
        );
      },
    );
  }
}
