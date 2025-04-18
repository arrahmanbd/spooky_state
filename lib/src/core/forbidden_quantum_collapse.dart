part of 'package:spooky_state/spooky_state.dart';

/// ❌ ForbiddenQuantumCollapse — Exception thrown when an illegal quantum operation is attempted
/// on a restricted waveform.
///
/// In quantum mechanics, certain operations on a system may be restricted due to the nature of
/// the wavefunction or its current state. This exception is thrown when a forbidden action, such as
/// an attempt to collapse or alter a waveform in an invalid way, occurs within the confines of a
/// restricted quantum state.
///
/// Example:
/// If a waveform has been entangled or locked in a specific superposition, performing a collapse,
/// emission, or observation could break the quantum state integrity. This exception prevents such
/// operations from being executed and ensures the integrity of the waveform state is maintained.
///
/// Usage:
/// ```dart
/// if (restrictedWaveform.isCollapsed) {
///   throw ForbiddenQuantumCollapse('collapse');
/// }
/// ```
class ForbiddenQuantumCollapse implements Exception {
  final String action;

  ForbiddenQuantumCollapse(this.action);

  @override
  String toString() =>
      'ForbiddenQuantumCollapse: The action "$action" is not allowed on a restricted waveform.';
}
