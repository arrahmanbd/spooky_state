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
  final QuantumBuilder<T> builder;
  final QuantumBuilderWithParticle<T>? builderWithSignal;

  const WavefunctionObserver({
    super.key,
    required this.waveform,
    required this.builder,
    this.builderWithSignal,
  }) : assert((builder != null) ^ (builderWithSignal != null));

  @override
  State<WavefunctionObserver<T>> createState() =>
      _WavefunctionObserverState<T>();
}

class _WavefunctionObserverState<T> extends State<WavefunctionObserver<T>> {
  late T _lastWaveValue;
  late QuantumWaveform _signal;
  StreamSubscription<T>? _subscription;

  @override
  void initState() {
    super.initState();
    _initSubscription(widget.waveform);
  }

  @override
  void didUpdateWidget(covariant WavefunctionObserver<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.waveform != widget.waveform) {
      _subscription?.cancel();
      _initSubscription(widget.waveform);
    }
  }

  void _initSubscription(SchrodingerBox<T> waveform) {
    _lastWaveValue = waveform.waveform;
    _signal = waveform.currentSignal;
    _subscription = waveform.field.listen((data) {
      if (mounted) {
        setState(() {
          _lastWaveValue = data;
          _signal = waveform.currentSignal;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    // 🚫 Don't call waveform.collapse() here
    // because this widget is only an observer, not the owner.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _lastWaveValue);
  }
}

/// Owns a [SchrodingerBox] and disposes it automatically when the widget is removed.
///
/// Use when the lifecycle of the waveform should be tied to the widget tree.
class WavefunctionProvider<T> extends StatefulWidget {
  final SchrodingerBox<T> Function() create;
  final Widget Function(BuildContext, SchrodingerBox<T>) builder;

  const WavefunctionProvider({
    super.key,
    required this.create,
    required this.builder,
  });

  @override
  State<WavefunctionProvider<T>> createState() =>
      _WavefunctionProviderState<T>();
}

class _WavefunctionProviderState<T> extends State<WavefunctionProvider<T>> {
  late final SchrodingerBox<T> _waveform;

  @override
  void initState() {
    super.initState();
    _waveform = widget.create();
  }

  @override
  void dispose() {
    _waveform.collapse(); // Dispose automatically
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _waveform);
  }
}

/// Generic type for any logic wrapper around a SchrodingerBox<T>
typedef WaveformLogic<T> = SchrodingerBox<T>;

/// A reusable provider for any WaveformLogic<T>
// class LogicProvider<T, L extends WaveformLogic<T>> extends StatefulWidget {
//   final L Function() create;
//   final Widget Function(BuildContext context, L logic) builder;

//   const LogicProvider({super.key, required this.create, required this.builder});

//   @override
//   State<LogicProvider<T, L>> createState() => _LogicProviderState<T, L>();
// }

// class _LogicProviderState<T, L extends WaveformLogic<T>> extends State<LogicProvider<T, L>> {
//   late final L _logic;

//   @override
//   void initState() {
//     super.initState();
//     _logic = widget.create();
//   }

//   @override
//   void dispose() {
//     _logic.collapse(); // automatically dispose the box
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(context, _logic);
//   }
// }
/// sUPPORT mODDLEWARE
///
class LogicProvider<T, L extends SchrodingerBox<T>> extends StatefulWidget {
  final L Function() create;
  final Widget Function(BuildContext context, L logic) builder;

  /// Optional middleware to attach immediately
  final List<QuantumMiddleware<T>>? middleware;

  const LogicProvider({
    super.key,
    required this.create,
    required this.builder,
    this.middleware,
  });

  @override
  State<LogicProvider<T, L>> createState() => _LogicProviderState<T, L>();
}

class _LogicProviderState<T, L extends SchrodingerBox<T>>
    extends State<LogicProvider<T, L>> {
  late final L _logic;

  @override
  void initState() {
    super.initState();
    _logic = widget.create();

    // Attach middleware if any
    if (widget.middleware != null) {
      for (final mw in widget.middleware!) {
        _logic.use(mw);
      }
    }
  }

  @override
  void dispose() {
    _logic.collapse();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _logic);
  }
}
