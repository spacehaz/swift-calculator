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
    (keys: [Key.digit(7)], expected: "7"),
    (keys: [.digit(1), .digit(2)], expected: "12"),
    (keys: [.digit(0), .digit(0), .digit(7)], expected: "7"),
])
func pressedDigits(
    keys: [Key],
    expected: String
) {
    let engineValue = display(after: keys)
    #expect(engineValue == expected)
}

@Test("Decimal point input", arguments: [
    (keys: [Key.digit(1), .decimalPoint, .digit(7)], expected: "1.7"),
    (keys: [.decimalPoint], expected: "0."),
    (keys: [.decimalPoint, .digit(5)], expected: "0.5"),
    (keys: [.digit(1), .decimalPoint, .digit(7), .decimalPoint], expected: "1.7")
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
    (keys: [.digit(1), .operation(.add), .digit(7), .digit(7), .equals], expected: "78"),
    (keys: [.digit(5), .operation(.subtract), .digit(3), .equals], expected: "2"),
    (keys: [.digit(3), .operation(.subtract), .digit(5), .equals], expected: "-2"),
    (keys: [.digit(1), .decimalPoint, .digit(5), .operation(.add), .digit(1), .equals], expected: "2.5"),
    (keys: [.digit(0), .decimalPoint, .digit(3), .operation(.subtract), .digit(0), .decimalPoint, .digit(1), .equals], expected: "0.2"),
    (keys: [.operation(.subtract), .digit(5), .equals], expected: "-5"),
]

@Test("Arithmetic", arguments: arithmeticCases)
func arithmetic(keys: [Key], expected: String) {
    #expect(display(after: keys) == expected)
}

let newNumberAfterOperationCases: [Case] = [
    (keys: [.digit(1), .operation(.add)], expected: "1"),
    (keys: [.digit(1), .operation(.add), .digit(7)], expected: "7"),
    (keys: [.digit(1), .operation(.add), .digit(7), .digit(7)], expected: "77"),
    (keys: [.digit(5), .operation(.add), .decimalPoint], expected: "0."),
]

@Test("New number after operation", arguments: newNumberAfterOperationCases)
func newNumberAfterOperation(keys: [Key], expected: String) {
    #expect(display(after: keys) == expected)
}

let chainingCases: [Case] = [
    (keys: [.digit(1), .operation(.add), .digit(1), .digit(1), .operation(.add)], expected: "12"),
    (keys: [.digit(1), .operation(.add), .digit(1), .digit(1), .operation(.add), .digit(1)], expected: "1"),
    (keys: [.digit(5), .operation(.add), .digit(2), .operation(.subtract), .digit(3), .equals], expected: "4"),
    (keys: [.operation(.add), .digit(5), .operation(.add), .digit(3), .equals], expected: "8"),
]

@Test("Chaining", arguments: chainingCases)
func chaining(keys: [Key], expected: String) {
    #expect(display(after: keys) == expected)
}

let equalsCases: [Case] = [
    (keys: [.digit(1), .operation(.add), .digit(2), .equals, .digit(5)], expected: "5"),
    (keys: [.digit(1), .operation(.add), .digit(2), .equals, .decimalPoint], expected: "0."),
    (keys: [.digit(7), .equals, .digit(5)], expected: "5"),
    (keys: [.digit(7), .equals, .decimalPoint, .digit(5)], expected: "0.5"),
    (keys: [.digit(7), .equals, .operation(.add), .digit(1), .equals], expected: "8"),
    (keys: [.digit(1), .operation(.add), .digit(2), .equals, .digit(7), .equals, .operation(.add), .digit(1), .equals], expected: "8"),
]

@Test("Equals", arguments: equalsCases)
func equals(keys: [Key], expected: String) {
    #expect(display(after: keys) == expected)
}

let operatorChangeCases: [Case] = [
    (keys: [.digit(5), .operation(.add), .operation(.subtract), .digit(3), .equals], expected: "2"),
    (keys: [.digit(1), .operation(.add), .operation(.add)], expected: "1"),
]

@Test("Operator change", arguments: operatorChangeCases)
func operatorChange(keys: [Key], expected: String) {
    #expect(display(after: keys) == expected)
}
