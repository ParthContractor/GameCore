//
//  RuleTests.swift
//  GameCore
//
//  Created by Parth Contractor on 8/9/2025.
//

import Testing
@testable import GameCore

@Suite("Rules for N×N Tic-Tac-Toe")
struct RulesSuite {

  @Test("Row wins for N in {3,5}")
  func row_wins() {
    for n in [3, 5] {
      for row in 0..<n {
        var s = GameState(n: n, current: .x)
        for c in 0..<n { s.board[row*n + c] = .x }
        #expect(Rules.status(for: s) == .win(.x), "N=\(n) row=\(row)")
      }
    }
  }

  @Test("Column wins for N in {3,5}")
  func col_wins() {
    for n in [3, 5] {
      for col in 0..<n {
        var s = GameState(n: n, current: .o)
        for r in 0..<n { s.board[r*n + col] = .o }
        #expect(Rules.status(for: s) == .win(.o), "N=\(n) col=\(col)")
      }
    }
  }

  @Test("Diagonal wins (main & anti) for N in {3,5}")
  func diag_wins() {
    for n in [3, 5] {
      // main diag
      do {
        var s = GameState(n: n, current: .x)
        for i in 0..<n { s.board[i*n + i] = .x }
        #expect(Rules.status(for: s) == .win(.x), "N=\(n) main diag")
      }
      // anti diag
      do {
        var s = GameState(n: n, current: .o)
        for i in 0..<n { s.board[i*n + (n-1-i)] = .o }
        #expect(Rules.status(for: s) == .win(.o), "N=\(n) anti diag")
      }
    }
  }

  @Test("Draw when full and no winner (N=3)")
  func draw_no_winner() {
    var s = GameState(n: 3)
    // A classic full-board draw
    s.board = [.x,.o,.x,
               .x,.o,.o,
               .o,.x,.x]
    #expect(Rules.status(for: s) == .draw)
  }

  @Test("Legal moves shrink during play, and are empty after terminal states")
  func legal_moves_contract() {
    var s = GameState(n: 3)
    #expect(Rules.legalMoves(s).count == 9)

    s = Rules.apply(0, to: s) // X
    #expect(Rules.status(for: s) == .playing)
    #expect(!Rules.legalMoves(s).contains(0))

    // force a win for X on top row: X at 1 & 2 (O plays elsewhere)
    s = Rules.apply(3, to: s) // O
    s = Rules.apply(1, to: s) // X
    s = Rules.apply(4, to: s) // O
    s = Rules.apply(2, to: s) // X wins

    #expect(Rules.status(for: s) == .win(.x))
    #expect(Rules.legalMoves(s).isEmpty, "No legal moves after win")
  }
}
