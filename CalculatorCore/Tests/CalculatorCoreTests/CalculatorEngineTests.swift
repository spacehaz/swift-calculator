import Testing
import CalculatorCore


func display(after keys: [Key]) -> String {
    var engine = CalculatorEngine()
    
    for key in keys {
        engine.press(key)
    }
    
    return engine.display
}

@Test("New calculator shows 0") func newCalculatorShowsZero() {
    let engine = CalculatorEngine()
    let initialValue = engine.display
    #expect(initialValue == "0")
}


@Test("Digit input", arguments: [
    (keys: [
        Key.digit(Digit.seven)
    ], expected: "7"),
    (keys: [
        .digit(Digit.one),
        .digit(Digit.two)
    ], expected: "12"),
    (keys: [
        .digit(Digit.zero),
        .digit(Digit.zero),
        .digit(Digit.seven)
    ], expected: "7"),
])
func pressedDigits(
    keys: [Key],
    expected: String
) {
    let engineValue = display(after: keys)
    #expect(engineValue == expected)
}

@Test("Decimal point input", arguments: [
    (keys: [
        Key.digit(Digit.one),
        .decimalPoint,
        .digit(Digit.seven)
    ], expected: "1.7"),
    (keys: [.decimalPoint], expected: "0."),
    (keys: [
        .decimalPoint,
        .digit(Digit.five)
    ], expected: "0.5"),
    (keys: [
        .digit(Digit.one),
        .decimalPoint,
        .digit(Digit.seven),
        .decimalPoint
    ], expected: "1.7")
])
func pressedDecimalPointWithDigits(
    keys: [Key],
    expected: String
) {
    let engineValue = display(after: keys)
    #expect(engineValue == expected)
}

// Typed constants give the compiler a target type: `@Test(arguments:)` is generic,
// so a big inline literal of tuples has to be inferred bottom-up and times out.
typealias Case = (keys: [Key], expected: String)

let arithmeticCases: [Case] = [
    (keys: [
        .digit(Digit.one),
        .operation(.add),
        .digit(Digit.seven),
        .digit(Digit.seven),
        .equals
    ], expected: "78"),
    (keys: [
        .digit(Digit.five),
        .operation(.subtract),
        .digit(Digit.three),
        .equals
    ], expected: "2"),
    (keys: [
        .digit(Digit.three),
        .operation(.subtract),
        .digit(Digit.five),
        .equals
    ], expected: "-2"),
    (keys: [
        .digit(Digit.one),
        .decimalPoint,
        .digit(Digit.five),
        .operation(.add),
        .digit(Digit.one),
        .equals
    ], expected: "2.5"),
    (keys: [
        .digit(Digit.zero),
        .decimalPoint,
        .digit(Digit.three),
        .operation(.subtract),
        .digit(Digit.zero),
        .decimalPoint,
        .digit(Digit.one),
        .equals
    ], expected: "0.2"),
    (keys: [
        .operation(.subtract),
        .digit(Digit.five),
        .equals
    ], expected: "-5"),
    (keys: [
        .digit(Digit.three),
        .operation(.multiply),
        .digit(Digit.five),
        .equals
    ], expected: "15"),
    (keys: [
        .digit(Digit.three),
        .operation(.multiply),
        .operation(.subtract),
        .digit(Digit.five),
        .equals
    ], expected: "-2"),
    (keys: [
        .digit(Digit.one),
        .digit(Digit.five),
        .operation(.divide),
        .digit(Digit.five),
        .equals
    ], expected: "3"),
]

@Test("Arithmetic", arguments: arithmeticCases)
func arithmetic(keys: [Key], expected: String) {
    #expect(display(after: keys) == expected)
}

let newNumberAfterOperationCases: [Case] = [
    (keys: [
        .digit(Digit.one),
        .operation(.add)
    ], expected: "1"),
    (keys: [
        .digit(Digit.one),
        .operation(.add),
        .digit(Digit.seven)
    ], expected: "7"),
    (keys: [
        .digit(Digit.one),
        .operation(.add),
        .digit(Digit.seven),
        .digit(Digit.seven)
    ], expected: "77"),
    (keys: [
        .digit(Digit.five),
        .operation(.add),
        .decimalPoint
    ], expected: "0."),
]

@Test("New number after operation", arguments: newNumberAfterOperationCases)
func newNumberAfterOperation(keys: [Key], expected: String) {
    #expect(display(after: keys) == expected)
}

let chainingCases: [Case] = [
    (keys: [
        .digit(Digit.one),
        .operation(.add),
        .digit(Digit.one),
        .digit(Digit.one),
        .operation(.add)
    ], expected: "12"),
    (keys: [
        .digit(Digit.one),
        .operation(.add),
        .digit(Digit.one),
        .digit(Digit.one),
        .operation(.add),
        .digit(Digit.one)
    ], expected: "1"),
    (keys: [
        .digit(Digit.five),
        .operation(.add),
        .digit(Digit.two),
        .operation(.subtract),
        .digit(Digit.three),
        .equals
    ], expected: "4"),
    (keys: [
        .operation(.add),
        .digit(Digit.five),
        .operation(.add),
        .digit(Digit.three),
        .equals
    ], expected: "8"),
]

@Test("Chaining", arguments: chainingCases)
func chaining(keys: [Key], expected: String) {
    #expect(display(after: keys) == expected)
}

let equalsCases: [Case] = [
    (keys: [
        .digit(Digit.one),
        .operation(.add),
        .digit(Digit.two), .equals,
        .digit(Digit.five)
    ], expected: "5"),
    (keys: [
        .digit(Digit.one),
        .operation(.add),
        .digit(Digit.two),
        .equals,
        .decimalPoint
    ], expected: "0."),
    (keys: [
        .digit(Digit.seven),
        .equals,
        .digit(Digit.five)
    ], expected: "5"),
    (keys: [
        .digit(Digit.seven),
        .equals,
        .decimalPoint,
        .digit(Digit.five)
    ], expected: "0.5"),
    (keys: [
        .digit(Digit.seven),
        .equals,
        .operation(.add),
        .digit(Digit.one),
        .equals
    ], expected: "8"),
    (keys: [
        .digit(Digit.one),
        .operation(.add),
        .digit(Digit.two),
        .equals,
        .digit(Digit.seven),
        .equals,
        .operation(.add),
        .digit(Digit.one),
        .equals
    ], expected: "8"),
]

@Test("Equals", arguments: equalsCases)
func equals(keys: [Key], expected: String) {
    #expect(display(after: keys) == expected)
}

let operatorChangeCases: [Case] = [
    (keys: [
        .digit(Digit.five),
        .operation(.add),
        .operation(.subtract),
        .digit(Digit.three),
        .equals
    ], expected: "2"),
    (keys: [
        .digit(Digit.one),
        .operation(.add),
        .operation(.add)
    ], expected: "1"),
]

@Test("Operator change", arguments: operatorChangeCases)
func operatorChange(keys: [Key], expected: String) {
    #expect(display(after: keys) == expected)
}
