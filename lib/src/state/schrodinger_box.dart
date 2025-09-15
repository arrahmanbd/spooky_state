part of 'package:spooky_state/spooky_state.dart';

/// 🧪 SchrödingerBox — A quantum-inspired state container.
///
/// Inspired by Schrödinger's famous thought experiment, this box holds a "particle" (state)
/// that is both present and undefined until observed. It acts as a quantum waveform,
/// capable of emitting values and quantum signals through a broadcast field.
///
/// In the quantum realm of microstates, observing is entangling. Observers can attach to the
/// box to reactively track its changes. The box can emit its current state (`resonate`),
/// broadcast new particles (`shift`), or transmit signals without necessarily changing the state.
///
/// A SchrödingerBox can:
/// - Entangle with external sources to stay in sync
/// - Be observed or restricted (read-only view via `restrictObservation`)
/// - Collapse when no longer needed
/// - Decoherence when separating from observers
///
/// Think of it like a quantum notifier — one that respects the elegance of uncertainty.
///
/// Example use cases:
/// - Observable value container with explicit signal control
/// - Complex state tracking in reactive systems
/// - Fine-grained dependency entanglement across widgets
///
/// 🪐 Collapse the wave. Resonate the field. Observe with caution.
///
/// See also:
/// - [QuantumWaveform] for signal types
/// - [restrictObservation] for controlled visibility
///
/// Middleware function signature: receives current and next state,
/// returns a modified state or null to cancel the update.
typedef QuantumMiddleware<T> = T? Function(T current, T next);

/// Maintains a single waveform and allows reactive updates, streams, and signals
class SchrodingerBox<T> implements Listenable {
  /// Current value of the box
  T waveform;

  /// Current signal/state of the box
  QuantumWaveform currentSignal = QuantumWaveform.idle;

  /// Stream broadcasting waveform changes
  final StreamController<T> _entanglementField =
      StreamController<T>.broadcast();

  /// Local listeners
  final List<VoidCallback> _listeners = [];

  /// Middleware chain
  final List<QuantumMiddleware<T>> _middleware = [];

  /// Stream subscriptions (auto-cancel on collapse)
  final List<StreamSubscription> _subscriptions = [];

  /// Internal observer & entanglement flags
  Function(SchrodingerBox<T>)? _observer;
  bool _observerEntangled = false;
  bool _canCollapse = true;
  Listenable? _source;

  SchrodingerBox({
    required this.waveform,
    this.currentSignal = QuantumWaveform.idle,
  });

  // ==============================
  // Middleware
  // ==============================

  /// Add a middleware to transform or block waveform updates
  void use(QuantumMiddleware<T> middleware) => _middleware.add(middleware);

  // ==============================
  // State Emission
  // ==============================

  /// Emits a new waveform, passing through middleware
  void shift(T newState, {QuantumWaveform signal = QuantumWaveform.emit}) {
    if (!_canCollapse) return;

    T processedState = newState;

    // Run all middleware
    for (final mw in _middleware) {
      final result = mw(waveform, processedState);
      if (result == null) return; // cancel update
      processedState = result;
    }

    waveform = processedState;
    currentSignal = signal;

    if (!_entanglementField.isClosed) _entanglementField.add(processedState);
    _notifyListeners();
  }

  /// Emits new state only if different
  void emitIfChanged(T newState) {
    if (waveform != newState) shift(newState);
  }

  /// Re-emit current state without change
  void resonate() {
    if (!_entanglementField.isClosed) _entanglementField.add(waveform);
    currentSignal = QuantumWaveform.resonate;
  }

  /// Emit a signal with optional new state
  void emitWithSignal(QuantumWaveform signal, {T? newState}) {
    if (newState != null && newState != waveform) {
      shift(newState, signal: signal);
    } else {
      if (!_entanglementField.isClosed) _entanglementField.add(waveform);
      currentSignal = signal;
    }
  }

  /// Send a signal without changing state
  void sendSignal(QuantumWaveform signal) {
    currentSignal = signal;
    if (!_entanglementField.isClosed) _entanglementField.add(waveform);
  }

  // ==============================
  // Entanglement / Observation
  // ==============================

  /// Entangle with an external Listenable
  bool entangle(Listenable source, Function(SchrodingerBox<T>) observer) {
    if (!_observerEntangled) {
      _source = source;
      _observer = observer;
      source.addListener(_observe);
      _observerEntangled = true;
      return true;
    }
    return false;
  }

  void _observe() => _observer?.call(this);

  /// Remove entanglement
  bool disentangle({Function()? decay}) {
    if (_observerEntangled && _source != null) {
      _observerEntangled = false;
      _source?.removeListener(_observe);
      decay?.call();
      _source = null;
      return true;
    }
    return false;
  }

  // ==============================
  // Stream & Async Support
  // ==============================

  /// Attach a stream to automatically emit values
  void attachStream(
    Stream<T> stream, {
    QuantumWaveform signal = QuantumWaveform.fluctuate,
  }) {
    final sub = stream.listen((value) {
      if (canEmit) shift(value, signal: signal);
    });
    _subscriptions.add(sub);
  }

  // ==============================
  // Lifecycle
  // ==============================

  /// Collapse the box and clean up
  void collapse() {
    // Cancel all stream subscriptions
    for (final sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();

    _entanglementField.close();
    _canCollapse = false;
    _source?.removeListener(_observe);
    _resetQuantumState();
    currentSignal = QuantumWaveform.collapse;
  }

  /// Reset box state optionally with signal
  void decohere({
    QuantumWaveform signal = QuantumWaveform.idle,
    bool clearObservers = true,
  }) {
    if (clearObservers) {
      _source?.removeListener(_observe);
      _resetQuantumState(signal: signal);
    }
  }

  void _resetQuantumState({QuantumWaveform signal = QuantumWaveform.idle}) {
    currentSignal = signal;
    _source = null;
    _observerEntangled = false;
    _observer = null;
  }

  // ==============================
  // Listenable Implementation
  // ==============================

  @override
  void addListener(VoidCallback listener) => _listeners.add(listener);

  @override
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  void _notifyListeners() {
    for (final l in _listeners) {
      l();
    }
  }

  // ==============================
  // Getters
  // ==============================

  /// Stream of waveform updates
  Stream<T> get field => _entanglementField.stream;

  /// Whether box can still emit
  bool get canEmit => _canCollapse;
}

// class SchrodingerBox<T> implements Listenable {
//   T waveform;
//   QuantumWaveform currentSignal = QuantumWaveform.idle;

//   final StreamController<T> _entanglementField =
//       StreamController<T>.broadcast();

//   Function(SchrodingerBox<T> wave)? _observer;
//   bool _observerEntangled = false;
//   bool _canCollapse = true;
//   Listenable? _source;

//   SchrodingerBox({
//     required this.waveform,
//     this.currentSignal = QuantumWaveform.idle,
//   });

//   /// The entangled stream of this box, broadcasting changes to observers.
//   Stream<T> get field => _entanglementField.stream;

//   /// Whether this box can still emit or has been collapsed.
//   bool get canEmit => _canCollapse;
//   final List<VoidCallback> _listeners = [];

//   @override
//   void addListener(VoidCallback listener) {
//     _listeners.add(listener);
//   }

//   @override
//   void removeListener(VoidCallback listener) {
//     _listeners.remove(listener);
//   }

//   void _notifyListeners() {
//     for (final l in _listeners) {
//       l();
//     }
//   }

//   /// Emits a new particle (state) into the entangled field.
//   void shift(T newState) {
//     waveform = newState;
//     _entanglementField.add(newState);
//     _notifyListeners();
//   }

//   /// Emits the new particle only if it differs from the current one.
//   void emitIfChanged(T newState) {
//     if (waveform != newState) {
//       shift(newState);
//     }
//   }

//   /// Re-emits the current particle into the field without changing it.
//   void resonate() {
//     _entanglementField.add(waveform);
//   }

//   /// Emits a signal along with an optional new particle.
//   void emitWithSignal(QuantumWaveform signal, {T? newState}) {
//     if (newState != null && newState != waveform) {
//       waveform = newState;
//       _entanglementField.add(newState);
//     } else {
//       _entanglementField.add(waveform);
//     }
//     currentSignal = signal;
//   }

//   /// Sends a signal without modifying the particle.
//   void sendSignal(QuantumWaveform signal) {
//     currentSignal = signal;
//     _entanglementField.add(waveform);
//   }

//   bool entangle(Listenable source, Function(SchrodingerBox<T> wave) observer) {
//     if (!_observerEntangled) {
//       _source = source;
//       _observer = observer;
//       source.addListener(_observe);
//       _observerEntangled = true;
//       return true;
//     }
//     return false;
//   }

//   void _observe() => _observer?.call(this);

//   bool disentangle({Function()? decay}) {
//     if (_observerEntangled && _source != null) {
//       _observerEntangled = false;
//       _source?.removeListener(_observe);
//       decay?.call();
//       _source = null;
//       return true;
//     }
//     return false;
//   }

//   void collapse() {
//     _entanglementField.close();
//     _canCollapse = false;
//     _source?.removeListener(_observe);
//     _resetQuantumState();
//   }

//   void decohere({
//     QuantumWaveform signal = QuantumWaveform.idle,
//     bool clearObservers = true,
//   }) {
//     if (clearObservers) {
//       _source?.removeListener(_observe);
//       _resetQuantumState(signal: signal);
//     }
//   }

//   void _resetQuantumState({QuantumWaveform signal = QuantumWaveform.idle}) {
//     // ⚡ reset to an "initial" value instead of null
//     currentSignal = signal;
//     _source = null;
//     _observerEntangled = false;
//     _observer = null;
//   }
// }

/// 🔒 _RestrictedWaveform — A read-only observer of a SchrödingerBox.
///
/// This class wraps a [SchrodingerBox] and restricts mutation methods,
/// effectively creating a collapsed observation window that cannot affect the waveform.
/// It's the quantum equivalent of peeking into the box without the ability to touch the particle.
///
/// All emit methods (`shift`, `resonate`, `emitWithSignal`) will throw a
/// [ForbiddenQuantumCollapse] to signal restricted access.
///
/// This is useful for exposing controlled observation points in your app:
/// - Prevent accidental state mutation in deeply nested widgets
/// - Maintain signal transparency while securing particle access
/// - Clean separation of "controllers" and "observers"
///
/// 🧲 Use `restrictObservation()` to safely create one.

class _RestrictedWaveform<T> extends SchrodingerBox<T> {
  final SchrodingerBox<T> _base;

  _RestrictedWaveform(this._base) : super(waveform: _base.waveform);

  // ⚠ Mutation methods are forbidden
  @override
  void shift(T newState, {QuantumWaveform signal = QuantumWaveform.emit}) =>
      throw ForbiddenQuantumCollapse("shift($newState, $signal)");

  @override
  void resonate() => throw ForbiddenQuantumCollapse("resonate()");

  @override
  void emitWithSignal(QuantumWaveform signal, {T? newState}) =>
      throw ForbiddenQuantumCollapse("emitWithSignal($signal, $newState)");

  @override
  void sendSignal(QuantumWaveform signal) => _base.sendSignal(signal);

  @override
  T get waveform => _base.waveform;

  @override
  QuantumWaveform get currentSignal => _base.currentSignal;

  @override
  StreamController<T> get _entanglementField => _base._entanglementField;

  @override
  bool get _observerEntangled => _base._observerEntangled;

  @override
  Listenable? get _source => _base._source;

  @override
  Function(SchrodingerBox<T>)? get _observer => _base._observer;

  @override
  void _observe() => _base._observe();

  @override
  bool entangle(Listenable source, Function(SchrodingerBox<T>) observer) =>
      _base.entangle(source, observer);

  @override
  bool disentangle({Function()? decay}) => _base.disentangle(decay: decay);

  @override
  void collapse() => _base.collapse();
}
