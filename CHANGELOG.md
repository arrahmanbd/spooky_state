# Changelog

## 2.0.0 – Entanglement

### Added

- Middleware system for `SchrodingerBox` to intercept and modify state updates
- `StreamQuantumBox` for stream-based async state management
- `QuantumWidget` with direct logic access in builder
- Example pages:
  - `QuantumTogglePage` (boolean toggle logic)
  - `CounterStreamPage` (streaming counter with signals)

### Changed

- `_RestrictedWaveform` updated to support read-only safe observation
- Proper lifecycle handling with collapse and subscription management

### Fixed

- Prevented broadcast stream errors when streams emit after collapse
- Professional handling of `QuantumWaveform` signals in async & stream boxes

### Notes

- Example app available in [`./example`](./example)
- Recommended for enterprise-ready apps using quantum-inspired state management

## 1.1.0 - Superposition (Release)

 Refactor: Remove nullable waveform from SchrodingerBox

## 1.0.1 - Fluctuation (Release)

* **Quantum Leap**: First stable release of **spooky_state** for Flutter.
* Introduced key quantum concepts:
  - **Wave-Particle Duality** in state management.
  - **Quantum Entanglement** for reactive state across the app.
  - **Superposition** to model states that collapse on user interaction.
* Designed for scalability, ease of use, and cosmic reactivity across your app.
* Developed with 💜 by **AR Rahman** for cosmic Flutterists.