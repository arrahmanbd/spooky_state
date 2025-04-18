part of 'package:spooky_state/spooky_state.dart';

/// 🧬 QuantumWaveform — Represents control particles governing a [SchrodingerBox]'s evolution.
///
/// In quantum systems, particles interact with fields, collapse into states,
/// and can be observed or entangled. `QuantumWaveform` acts as a symbolic
/// control signal—governing how a [SchrodingerBox] evolves over time.
///
/// Each static instance represents a specific transformation in the quantum system:
///
/// - 🔻 `collapse` — Final collapse of the waveform, closing emissions.
/// - 🌌 `decohere` — Ends entanglement and resets the waveform.
/// - 🧲 `entangle` — Binds to an external source, becoming reactive.
/// - 📡 `emit` — Emits a new particle (state) to observers.
/// - 👁️ `observe` — Begins active observation of the waveform.
/// - 🌊 `superpose` — Suspends in a waveform state, before a decision.
/// - 💤 `idle` — Neutral starting or resting state.
/// - 🔄 `fluctuate` — Reevaluates based on surrounding conditions.
/// - 🔔 `resonate` — Repeats the current state without change (ping).
/// - 🌀 `quantumFlux` — Represents instability or lag within the system.
///
/// You can also emit custom quantum signals using:
///
/// ```dart
/// QuantumWaveform.customSignal('my_signal')
/// ```
///
/// These control particles can be observed to perform UI updates,
/// trigger logic flows, or drive animations within a reactive
/// quantum-inspired architecture.

class QuantumWaveform {
  final String value;
  const QuantumWaveform._(this.value);

  static const QuantumWaveform collapse =
      QuantumWaveform._('collapse'); // Final state
  static const QuantumWaveform decohere =
      QuantumWaveform._('decohere'); // End processing
  static const QuantumWaveform entangle =
      QuantumWaveform._('entangle'); // Bind state
  static const QuantumWaveform emit = QuantumWaveform._('emit'); // Emit data
  static const QuantumWaveform observe =
      QuantumWaveform._('observe'); // Start observation
  static const QuantumWaveform superpose =
      QuantumWaveform._('superpose'); // Pause as wave
  static const QuantumWaveform idle =
      QuantumWaveform._('idle'); // Initial or passive state
  static const QuantumWaveform fluctuate =
      QuantumWaveform._('fluctuate'); // Re-evaluate
  static const QuantumWaveform resonate =
      QuantumWaveform._('resonate'); // Update without change
  static const QuantumWaveform quantumFlux =
      QuantumWaveform._('quantum_flux'); // Lagging behind
  static const QuantumWaveform custom = QuantumWaveform._('custom');

  factory QuantumWaveform.customSignal(String value) =>
      QuantumWaveform._(value);

  @override
  bool operator ==(Object other) =>
      other is QuantumWaveform && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'QuantumWaveform.$value';
}
