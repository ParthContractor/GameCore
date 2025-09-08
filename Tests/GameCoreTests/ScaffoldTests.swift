import Testing
@testable import GameCore

@Suite("GameCore scaffolding")
struct GameCoreScaffoldTests {

    @Test("Initial state has n*n cells and X to move")
    func initial_state() {
        let s = GameState(n: 3)
        #expect(s.board.count == 9)
        #expect(s.current == .x)
    }

    @Test("Apply places a mark and toggles player")
    func apply_places_and_toggles() {
        var s = GameState(n: 3, current: .x)
        s = Rules.apply(0, to: s)
        #expect(s.board[0] == .x)
        #expect(s.current == .o)
    }
}
