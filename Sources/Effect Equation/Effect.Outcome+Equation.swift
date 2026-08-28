public import Effect
public import Equation_Protocol

extension Effect::Effect.Outcome: @retroactive Equation::Equation.`Protocol`
where
    Value: Equation::Equation.`Protocol` & ~Copyable,
    Failure: Equation::Equation.`Protocol`
{

    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        switch lhs {
        case .resumed(let lv):
            switch rhs {
            case .resumed(let rv): return lv == rv
            case .threw: return false
            case .aborted: return false
            }

        case .threw(let le):
            switch rhs {
            case .resumed: return false
            case .threw(let re): return le == re
            case .aborted: return false
            }

        case .aborted:
            switch rhs {
            case .resumed: return false
            case .threw: return false
            case .aborted: return true
            }
        }
    }
}
