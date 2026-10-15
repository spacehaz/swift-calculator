import Foundation

public struct CalculatorEngine: Sendable {
    
//    what user cuurrently can see on the display
    public private(set) var display: String = "0"
    
// what is already counted
    private var storedValue: Decimal? = nil
    
// is the calculator ready for the next value input?
    private var startsNewNumber: Bool = true
    
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
                        self.storedValue = Decimal(string: self.display)!
                    }
                    
                    return
                }

                if let operation {
                    calculate(operation)
                } else {
                    self.storedValue = Decimal(string: self.display)!
                }
                self.operation = value
                self.startsNewNumber = true
            case .equals:
                if let operation {
                    calculate(operation)
                }
                self.operation = nil
                startsNewNumber = true
        }
    }
    
    
    
    private func add(_ value1: Decimal, _ value2: Decimal) -> Decimal {
        return value1 + value2
    }
    
    private mutating func calculate (
        _ currentOperation: Operation,
    ) {
        switch currentOperation {
            case .add:
            if let value1 = storedValue, let value2 = Decimal(string: display) {
                    let result = add(value1, value2)
                self.storedValue = result
                self.display = "\(result)"
            }
        }
    }
}
