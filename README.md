# GameCore

Pure Swift **N×N** Tic-Tac-Toe domain logic (no UI).

- **Value semantics** (`GameState` as struct)
- **Pure rules** (`Rules.status / legalMoves / apply`)
- **Framework-agnostic** (SwiftUI / UIKit / macOS / CLI)

## Requirements
Swift 6 • iOS 17+ / macOS 14+

## Install
- Xcode → **Add Packages…** → select this repo (or **Add Local…**).
- Link the **GameCore** product to your app target.

## Tests
- Included (Swift Testing). Run: swift test

## Usage
```swift
import GameCore

var s = GameState(n: 3)          // X to move
s = Rules.apply(0, to: s)        // X plays; O to move
switch Rules.status(for: s) {
case .playing: break
case .win(let p): print("\(p) wins")
case .draw: print("Draw")
}

