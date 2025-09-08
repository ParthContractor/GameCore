public enum Player: String, Sendable { case x, o }

/// Value-type state for an N×N two-player Tic-Tac-Toe board.
public struct GameState: Sendable, Equatable {
    public let n: Int
    public var board: [Player?]   // length n*n, row-major
    public var current: Player

    /// Default: n = 3, X to move.
    public init(n: Int = 3, board: [Player?]? = nil, current: Player = .x) {
        precondition(n >= 3, "n must be >= 3")
        self.n = n
        self.board = board ?? Array(repeating: nil, count: n * n)
        self.current = current
    }
}
