part of 'package:spooky_state/spooky_state.dart';

typedef QuantumBuilderWithLogic<T, L extends SchrodingerBox<T>> =
    Widget Function(BuildContext context, T value, L logic);

class QuantumWidget<T, L extends SchrodingerBox<T>> extends StatefulWidget {
  /// Factory to create the logic/box
  final L Function() create;

  /// Builder to render UI based on waveform & logic
  final QuantumBuilderWithLogic<T, L> builder;

  /// Optional middleware
  final List<QuantumMiddleware<T>>? middleware;

  const QuantumWidget({
    super.key,
    required this.create,
    required this.builder,
    this.middleware,
  });

  @override
  State<QuantumWidget<T, L>> createState() => _QuantumWidgetState<T, L>();
}

class _QuantumWidgetState<T, L extends SchrodingerBox<T>>
    extends State<QuantumWidget<T, L>> {
  late final L _logic;
  late T _lastValue;
  late StreamSubscription<T> _subscription;

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

    _lastValue = _logic.waveform;
    _subscription = _logic.field.listen((value) {
      if (mounted) {
        setState(() {
          _lastValue = value;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    _logic.collapse();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _lastValue, _logic);
  }
}

// class AsyncQuantumBox<T> extends SchrodingerBox<T?> {
//   AsyncQuantumBox({T? initial}) : super(waveform: initial);

//   /// Run async operation with signals
//   Future<void> runAsync(Future<T> Function() asyncTask) async {
//     sendSignal(QuantumWaveform.observe); // starting
//     try {
//       final result = await asyncTask();
//       emitWithSignal(QuantumWaveform.emit, newState: result);
//       sendSignal(QuantumWaveform.resonate); // custom success signal
//     } catch (e) {
//       sendSignal(QuantumWaveform.decohere);
//       rethrow;
//     }
//   }
// }

/// Async version of SchrodingerBox for Future-based state updates
class AsyncQuantumBox<T> extends SchrodingerBox<T> {
  /// Track the latest active async operation
  Future<T>? _activeFuture;
  bool _isLoading = false;

  AsyncQuantumBox({required super.waveform});

  /// Whether the box is currently processing an async task
  bool get isLoading => _isLoading;

  /// Run an async task and automatically update waveform when done
  /// Emits signals during the lifecycle: `fluctuate` -> `emit` / `decohere`
  void runAsync(
    Future<T> Function() asyncTask, {
    QuantumWaveform startSignal = QuantumWaveform.fluctuate,
    QuantumWaveform? completeSignal,
    QuantumWaveform? errorSignal,
    void Function(Object error)? onError,
  }) {
    if (!canEmit) return;

    _isLoading = true;
    emitWithSignal(startSignal);

    final future = asyncTask();
    _activeFuture = future;

    future
        .then((result) {
          if (!canEmit) return;
          // Only update if this is the latest future
          if (_activeFuture == future) {
            shift(result, signal: completeSignal ?? QuantumWaveform.emit);
            _isLoading = false;
          }
        })
        .catchError((error) {
          _isLoading = false;
          emitWithSignal(errorSignal ?? QuantumWaveform.decohere);
          if (onError != null) onError(error);
        });
  }

  /// Cancel the current active async task
  /// Note: Dart Futures cannot be forcibly cancelled, but this ignores old results
  void cancelAsync() {
    _activeFuture = null;
    _isLoading = false;
    emitWithSignal(QuantumWaveform.decohere);
  }
}

class StreamQuantumBox<T> extends SchrodingerBox<T> {
  StreamQuantumBox({required super.waveform});

  @override
  void attachStream(
    Stream<T> stream, {
    QuantumWaveform signal = QuantumWaveform.fluctuate,
  }) {
    stream.listen((value) {
      shift(value);
    });
  }
}
