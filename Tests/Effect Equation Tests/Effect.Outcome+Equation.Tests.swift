import Effect
import Testing

@testable import Effect_Equation

@Suite
struct `Effect.Outcome Equation Tests` {

    @Test
    func `equatable for resumed`() {
        let a: Effect.Outcome<Int, Never> = .resumed(1)
        let b: Effect.Outcome<Int, Never> = .resumed(1)
        let c: Effect.Outcome<Int, Never> = .resumed(2)

        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func `equatable for threw`() {
        struct E: Swift.Error, Equatable {
            let code: Int
        }

        let a: Effect.Outcome<Int, E> = .threw(E(code: 1))
        let b: Effect.Outcome<Int, E> = .threw(E(code: 1))
        let c: Effect.Outcome<Int, E> = .threw(E(code: 2))

        #expect(a == b)
        #expect(a != c)
    }

    @Test
    func `equatable for aborted`() {
        let a: Effect.Outcome<Int, Never> = .aborted
        let b: Effect.Outcome<Int, Never> = .aborted

        #expect(a == b)
    }

    @Test
    func `different cases not equal`() {
        struct E: Swift.Error, Equatable {}

        let resumed: Effect.Outcome<Int, E> = .resumed(1)
        let threw: Effect.Outcome<Int, E> = .threw(E())
        let aborted: Effect.Outcome<Int, E> = .aborted

        #expect(resumed != threw)
        #expect(resumed != aborted)
        #expect(threw != aborted)
    }
}
