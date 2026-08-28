public import Effect
public import Equation_Protocol

extension Effect::Effect.Outcome: @retroactive Equation::Equation.`Protocol`
where
    Value: Equation::Equation.`Protocol` & ~Copyable,
    Failure: Equation::Equation.`Protocol`
{}
