part of 'package:spooky_state/spooky_state.dart';

/// 🌠 QuantumBuilder — A signature for building UI based on quantum emissions.
///
/// The `QuantumBuilder` defines a function that receives the current state of a quantum waveform
/// (a particle) and rebuilds the UI based on that state. This allows the UI to be dynamically
/// updated whenever the quantum state evolves or emits new values. This function is typically used
/// in situations where the UI needs to react to changes in the waveform's state or the emitted
/// signals.
///
/// Usage:
/// ```dart
/// QuantumObserver(
///   waveform: someQuantumWaveform,
///   builder: (context, state) {
///     return Text('Current state: $state');
///   },
/// );
/// ```
typedef QuantumBuilder<T> = Widget Function(BuildContext context, T? state);

/// 🌠 QuantumBuilderWithParticle — A signature for building UI based on quantum emissions
/// and the associated signal waveform.
///
/// The `QuantumBuilderWithParticle` extends the basic `QuantumBuilder` by adding the ability
/// to also access the current quantum signal (e.g., `collapse`, `entangle`, `observe`) alongside
/// the state of the waveform. This is useful when the UI needs to react not only to the state of
/// the waveform but also to the specific signal that is influencing or controlling the waveform's
/// evolution.
///
/// Usage:
/// ```dart
/// QuantumObserver(
///   waveform: someQuantumWaveform,
///   builderWithSignal: (context, state, signal) {
///     return Text('State: $state, Signal: $signal');
///   },
/// );
/// ```
typedef QuantumBuilderWithParticle<T> =
    Widget Function(BuildContext context, T? state, QuantumWaveform signal);
