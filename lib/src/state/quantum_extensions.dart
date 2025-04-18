part of 'package:spooky_state/spooky_state.dart';

/// 🧲 Extension to create a restricted (read-only) observer from a quantum waveform.
extension WavefunctionObserverExtension<T> on SchrodingerBox<T> {
  SchrodingerBox<T> restrictObservation() => _RestrictedWaveform<T>(this);
}

extension QuantumObservationX<T> on SchrodingerBox<T> {
  /// 🔭 Observe this waveform and rebuild UI when it emits.
  ///
  /// Equivalent to using [WavefunctionObserver] with the simpler builder.
  Widget observe(Widget Function(T? value) builder) {
    return WavefunctionObserver<T>(
      waveform: this,
      builder: (context, value) => builder(value),
    );
  }

  /// 🪐 Observe this waveform and rebuild UI using both value and quantum signal.
  ///
  /// Useful when you need to react differently to signal types like `emit`, `resonate`, or `collapse`.
  Widget observeWithSignal(
    Widget Function(T? value, QuantumWaveform signal) builder,
  ) {
    return WavefunctionObserver<T>(
      waveform: this,
      builderWithSignal: (context, value, signal) => builder(value, signal),
    );
  }
}

/// 🌌 Extensions to simplify observing quantum waveforms in Flutter widgets.
extension QuantumWaveContextExtensions on BuildContext {
  /// 🔭 Observes a [SchrodingerBox] and rebuilds a widget when the emitted state changes.
  ///
  /// Example:
  /// ```dart
  /// context.watch(counterBox, (value) => Text('$value'));
  /// ```
  Widget watch<T>(
    SchrodingerBox<T> waveform,
    Widget Function(T? state) builder,
  ) {
    return WavefunctionObserver<T>(
      waveform: waveform,
      builder: (_, state) => builder(state),
    );
  }

  /// 🌠 Observes a [SchrodingerBox] and rebuilds a widget using both state and signal.
  ///
  /// Example:
  /// ```dart
  /// context.watchWithSignal(counterBox, (value, signal) => Text('$value - $signal'));
  /// ```
  Widget watchWithSignal<T>(
    SchrodingerBox<T> waveform,
    Widget Function(T? state, QuantumWaveform signal) builder,
  ) {
    return WavefunctionObserver<T>(
      waveform: waveform,
      builderWithSignal: (_, state, signal) => builder(state, signal),
    );
  }

  /// 🔒 Observes a [SchrodingerBox] in restricted mode (read-only), useful for UI that reacts but shouldn't mutate state.
  Widget readOnly<T>(
    SchrodingerBox<T> waveform,
    Widget Function(T? state) builder,
  ) {
    return WavefunctionObserver<T>(
      waveform: waveform.restrictObservation(),
      builder: (_, state) => builder(state),
    );
  }
}
