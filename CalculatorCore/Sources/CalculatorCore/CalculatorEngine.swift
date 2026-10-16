import Foundation

public struct CalculatorEngine: Sendable {

//    what user cuurrently can see on the display
    public private(set) var display: String = "0"

// what is already counted
    private var storedValue: Decimal? = nil

// is the calculator ready for the next value input?
    private var startsNewNumber: Bool = true

    private var decimalDisplay: Decimal {
        Decimal(string: self.display)!
    }

// what is the current operation to do
    private var operation: Operation?

    public init () {}

    public mutating func press(_ key: Key) {
        switch key {
            case .digit(let value):
                if display == "0" || startsNewNumber {
                    self.startsNewNumber = false
                    self.display = String(value)
                } else {
                    self.display += String(value)
                }
            case .decimalPoint:
                if self.startsNewNumber {
                    self.display = "0."
                } else if !display.contains(".") {
                    self.display += "."
                }
                self.startsNewNumber = false
            case .operation(let value):
        
                if startsNewNumber {
                    self.operation = value
                    if self.storedValue == nil {
                        self.storedValue = decimalDisplay
                    }
                    
                    return
                }

                if let operation {
                    calculate(operation)
                } else {
                    self.storedValue = decimalDisplay
                }

                self.operation = value
                self.startsNewNumber = true
            case .equals:
                if let operation {
                    calculate(operation)
                }
                self.operation = nil
                startsNewNumber = true
                self.storedValue = nil
        }
    }
    
    private mutating func calculate (
        _ currentOperation: Operation,
    ) {
        guard let value1 = storedValue else { return }
        let result: Decimal = switch currentOperation {
            case .add: value1 + decimalDisplay
            case .subtract: value1 - decimalDisplay
        }
        self.storedValue = result
        self.display = "\(result)"
    }
}
