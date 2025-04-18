part of 'package:spooky_state/spooky_state.dart';

/// 🧬 WavefunctionObserver — A UI widget that reacts to quantum emissions.
///
/// This widget listens to a [SchrodingerBox] (the wavefunction) and rebuilds
/// when a new particle state is emitted or a quantum signal is sent.
///
/// It acts as a visual observer, triggering the collapse of the waveform
/// into a concrete UI state. Just like in quantum physics, observation
/// alters reality—here, it updates your Flutter UI.
///
/// 🧠 You can choose to observe just the particle (`builder`),
/// or also respond to emitted quantum signals (`builderWithSignal`).
///
/// ```dart
/// WavefunctionObserver<int>(
///   waveform: counterBox,
///   builder: (context, value) => Text('$value'),
/// );
/// ```
///
/// 🧲 Only one of [builder] or [builderWithSignal] must be provided.
/// This allows fine-tuned control over how much quantum information
/// the observer is aware of.
///
/// See also:
/// - [SchrodingerBox] for the source waveform
/// - [QuantumWaveform] for the available signal types
/// 🔭 Observes emissions from a quantum waveform and rebuilds UI accordingly.
class WavefunctionObserver<T> extends StatefulWidget {
  final SchrodingerBox<T> waveform;
  final QuantumBuilder<T>? builder;
  final QuantumBuilderWithParticle<T>? builderWithSignal;

  const WavefunctionObserver({
    super.key,
    required this.waveform,
    this.builder,
    this.builderWithSignal,
  }) : assert((builder != null) ^ (builderWithSignal != null));

  @override
  State<WavefunctionObserver<T>> createState() =>
      _WavefunctionObserverState<T>();
}

class _WavefunctionObserverState<T> extends State<WavefunctionObserver<T>> {
  T? _lastWaveValue;
  QuantumWaveform _signal = QuantumWaveform.idle;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _lastWaveValue = widget.waveform.waveform;
    _signal = widget.waveform.currentSignal;
    _subscription = widget.waveform.field.listen((data) {
      setState(() {
        _lastWaveValue = data;
        _signal = widget.waveform.currentSignal;
      });
    });
  }

  @override
  void didUpdateWidget(covariant WavefunctionObserver<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.waveform != widget.waveform) {
      _subscription?.cancel();
      _lastWaveValue = widget.waveform.waveform;
      _signal = widget.waveform.currentSignal;
      _subscription = widget.waveform.field.listen((data) {
        setState(() {
          _lastWaveValue = data;
          _signal = widget.waveform.currentSignal;
        });
      });
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builder != null) {
      return widget.builder!(context, _lastWaveValue);
    } else {
      return widget.builderWithSignal!(context, _lastWaveValue, _signal);
    }
  }
}
