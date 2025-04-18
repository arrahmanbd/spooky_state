
# 🧪 Quantum State Management for Flutter

> _“Everything we call real is made of things that cannot be regarded as real.”_  
> — **Niels Bohr**

Welcome to **spooky_state** — a new dimension in Flutter state management, where reactivity collides with the bizarre beauty of **quantum theory**.

Inspired by the principles of **wave-particle duality**, **entanglement**, and **superposition**, this package introduces a powerful yet intuitive system for managing state in Flutter apps. It's designed to scale elegantly, feel natural to use, and remain deeply reactive at its core.

> _“The state is neither alive nor dead... until you observe it.”_  
> — **AR**

---

## ⚛️ What is This?

A lightweight, reactive, and extensible state management library for Flutter apps — themed around quantum physics, yet built for practical use.

Core concepts:
- **Waveforms** (`SchrodingerBox`) that hold and emit state
- **Particles** (`QuantumWaveform`) that describe changes, not just values
- **Observation** (`WavefunctionObserver`) that rebuilds the UI like a physicist collapsing a wave
- **Entanglement** (extension methods) that keep UI and logic in sync — like spooky action at a distance

---

## 🧬 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  micro_state: ^1.0.0 
```

---

## 🌌 Core Concepts

### 🪐 `SchrödingerBox<T>`

Imagine you have a cat inside a box. Is it alive or dead? Well, until you open the box, it's both—alive and dead—existing in a superposition of possibilities. This is exactly how `SchrödingerBox<T>` works in your app: it holds a state in a waveform, neither fully alive nor dead until you "observe" it.

In code terms, `SchrödingerBox<T>` holds a value that exists in an indeterminate state. When you observe it, you collapse the waveform into a definite value. It’s the perfect analogy to the famous quantum cat experiment: your app’s state is both alive and dead until you interact with it.

---

### 🐱 The Quantum Cat

Let’s make it clear with the cat in the box. In quantum mechanics, the cat is both alive and dead until you check. Similarly, `SchrödingerBox<T>` holds a state in flux—its value is uncertain until you observe it, causing the waveform to collapse. It’s a dynamic and reactive approach to state management.

---

### 🌌 How It Works

`SchrödingerBox<T>` gives you:

1. **Superposition**: The state exists in an uncertain waveform.
2. **Waveform Emission**: Like Schrödinger’s cat, it only "emits" a value when you observe it.
3. **State Observation**: Upon observation, the state collapses into a definitive value, just like when you check the box to see if the cat is alive or dead.

---

### 🚀 In Action

```dart
class QuantumCatState extends SchrodingerBox<bool> {
  QuantumCatState() : super(waveform: false);  // Cat is in superposition.

  void observeCat() => shift(true);  // Collapse to alive.
  void checkCat() => shift(false);   // Collapse to dead.
}

QuantumCatState catState = QuantumCatState();
catState.observeCat();  // The cat is alive (or is it?).
catState.checkCat();    // The cat is dead (or is it?).
```

---

### 🌟 Get Started

Just like Schrödinger’s cat, your app's state exists in quantum uncertainty until you observe it. `SchrödingerBox<T>` brings this elegant, reactive pattern to Flutter, making your state management dynamic, efficient, and fun. So, it Represents a state that exists in a waveform — a container for any observable value.

```dart
final counter = SchrodingerBox<int>(waveform: 0);
```

You can **shift** the waveform:

```dart
counter.shift(counter.waveform! + 1);
```

Or **collapse** it when no longer needed:

```dart
counter.collapse();
```

---

### 🔭 `WavefunctionObserver<T>`

This widget observes quantum waveforms and rebuilds when the state (or signal) changes:

```dart
WavefunctionObserver<int>(
  waveform: counter,
  builder: (context, value) => Text('Counter: $value'),
)
```

Or, observe both the value and the type of particle (signal):

```dart
WavefunctionObserver<int>(
  waveform: counter,
  builderWithSignal: (context, value, signal) {
    return Text('[$signal] $value');
  },
)
```

---

### ⚡ Quick Observe with Extension

You can observe directly using `.observe()` extension:

```dart
counter.observe((value) => Text('Counter: $value'));
```

Or, observe with signal:

```dart
counter.observeWithSignal(
  (value, signal) => Text('[$signal] $value'),
);
```

---

## 🧲 Example: Toggle

```dart
class ToggleLogic {
  final toggleWaveform = SchrodingerBox<bool>(waveform: false);

  void toggle() => toggleWaveform.shift(!toggleWaveform.waveform!);
}
```

```dart
class QuantumTogglePage extends StatelessWidget {
  final logic = ToggleLogic();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        logic.toggleWaveform.observe(
          (value) => Text(value! ? 'ON' : 'OFF'),
        ),
        ElevatedButton(
          onPressed: logic.toggle,
          child: const Text('Toggle'),
        ),
      ],
    );
  }
}
```

---

## 🛰️ Signals (aka `QuantumWaveform`)

Signals are the "particles" that inform how or why state changed:

```dart
QuantumWaveform.emit        // Regular emission
QuantumWaveform.entangle    // External state sync
QuantumWaveform.superpose   // Intermediate state
QuantumWaveform.collapse    // Disposal
QuantumWaveform.decohere    // Transition stop
```

Custom signal?

```dart
final signal = QuantumWaveform.customSignal("quasar_burst");
```

---

## 🧨 Exception: `ForbiddenQuantumCollapse`

Thou shalt not mutate a collapsed box.

```dart
throw ForbiddenQuantumCollapse('shift after collapse');
```

---

## 🧠 Why Quantum?

- Quantum physics has elegant patterns — so should your state system.
- You control _not just the state_, but the _intent_ behind the change.
- It's fun. 😎

---

## 🛸 Roadmap

- [x] Signal tagging and rich particle context
- [x] One-liner observe extensions
- [ ] Async entanglement (Future/Stream states)
- [ ] Quantum debugging console?

---

## 🧭 Philosophy

This isn't just about managing state. It's about designing **systems of state** — where logic and UI are entangled, observed, and evolved in elegant harmony.

> _"The observer changes the observed."_  
> — Quantum Theory (and AR)

---

## 🧩 Contributions

Pull requests, issue reports, and cool particle name suggestions are warmly welcome!

---

## 🔖 License

MIT — feel free to collapse and decohere responsibly.

Crafted with 💜 and quantum devotion by AR Rahman for the cosmic Flutterists, where every line of code resonates through the universe.
