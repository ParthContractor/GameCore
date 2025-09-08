//
//  Rules.swift
//  GameCore
//
//  Created by Parth Contractor on 8/9/2025.
//

public enum GameStatus: Equatable, Sendable { case playing, win(Player), draw }

public enum Rules {
  public static func status(for s: GameState) -> GameStatus {
    let n = s.n, b = s.board
    for line in lines(n) {
      if let p = b[line[0]], line.allSatisfy({ b[$0] == p }) { return .win(p) }
    }
    return b.contains(where: { $0 == nil }) ? .playing : .draw
  }

  public static func legalMoves(_ s: GameState) -> [Int] {
    guard case .playing = status(for: s) else { return [] }
    return s.board.indices.filter { s.board[$0] == nil }
  }

  public static func apply(_ move: Int, to s: GameState) -> GameState {
    guard case .playing = status(for: s) else { preconditionFailure("not playing") }
    let limit = s.n * s.n
    precondition((0..<limit).contains(move), "out of range")
    precondition(s.board[move] == nil, "cell not empty")
    var next = s
    next.board[move] = s.current
    next.current = (s.current == .x) ? .o : .x
    return next
  }

  // All row/col/diag index sets for an N×N board.
  private static func lines(_ n: Int) -> [[Int]] {
    let rows = (0..<n).map { r in (0..<n).map { r*n + $0 } }
    let cols = (0..<n).map { c in (0..<n).map { $0*n + c } }
    let main = (0..<n).map { $0*(n+1) }
    let anti = (0..<n).map { $0*n + (n-1-$0) }
    return rows + cols + [main, anti]
  }
}

