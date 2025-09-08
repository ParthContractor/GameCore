# GameCore

Pure Swift **domain logic** for a two-player **N×N** Tic-Tac-Toe game.

## Responsibilities
- Value-type game state (`GameState`)
- Pure functions for rules (`Rules`): `status`, `legalMoves`, `apply`
- **No UI**, no geometry, no globals

## Public API
```swift
public struct GameState { public let n: Int; public var board: [Player?]; public var current: Player }
public enum Player { case x, o }
public enum GameStatus { case playing, win(Player), draw }
public enum Rules {
  public static func status(for: GameState) -> GameStatus
  public static func legalMoves(_ s: GameState) -> [Int]
  public static func apply(_ move: Int, to s: GameState) -> GameState
}
```

## Usage
```swift
import GameCore

var state = GameState(n: 3)
state = Rules.apply(0, to: state)
let status = Rules.status(for: state)
```
