public enum GameStatus: Equatable, Sendable {
    case playing
    case win(Player)
    case draw
}

/// Game rules (placeholder implementations for Step 1).
/// Step 2 will implement full winner/draw detection.
public enum Rules {
    /// Returns .playing if any cell is empty, else .draw.
    public static func status(for state: GameState) -> GameStatus {
        return state.board.contains(where: { $0 == nil }) ? .playing : .draw
    }

    /// Returns indices of empty cells while game is .playing.
    public static func legalMoves(_ state: GameState) -> [Int] {
        guard case .playing = status(for: state) else { return [] }
        return state.board.indices.filter { state.board[$0] == nil }
    }

    /// Place current player's mark at `move` and toggle player.
    public static func apply(_ move: Int, to state: GameState) -> GameState {
        precondition((0..<(state.n * state.n)).contains(move), "move out of range")
        precondition(state.board[move] == nil, "illegal move: cell already taken")
        var next = state
        next.board[move] = state.current
        next.current = (state.current == .x) ? .o : .x
        return next
    }
}
