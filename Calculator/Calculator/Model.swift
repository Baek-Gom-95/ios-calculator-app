//
//  model.swift
//  Calculator
//
//  Created by Red on 2022/03/15.
//

import Foundation

protocol CalculateItem {
    // empty
}
enum CalculatorError: Error {
    case dividedWithZero
}

enum Operator: Character, CaseIterable, CalculateItem {
    case add = "+"
    case subtract = "-"
    case multiply = "×"
    case divide = "÷"
    
    func calculate(lhs: Double, rhs: Double) -> Double {
        switch self {
        case .add:
            return self.add(lhs: lhs, rhs: rhs)
        case .subtract:
            return self.subtract(lhs: lhs, rhs: rhs)
        case .divide:
            return self.divided(lhs: lhs, rhs: rhs)
        case .multiply:
            return self.mutiply(lhs: lhs, rhs: rhs)
        }
    }
    
    func add(lhs: Double, rhs: Double) -> Double {
        return lhs + rhs
    }
    
    func subtract(lhs: Double, rhs: Double) -> Double {
        return lhs - rhs
    }
    
    func divided(lhs: Double, rhs: Double) -> Double {
        return lhs / rhs
    }
    
    func mutiply(lhs: Double, rhs: Double) -> Double {
        return lhs * rhs
    }
}

extension Double: CalculateItem {
}

struct CalculatorItemQueue<T: CalculateItem> {
    private(set) var queue: [Int: T] = [:]
    private(set) var head: Int = 0
    private(set) var tail: Int = 0
    
    var isEmpty: Bool {
        return queue.isEmpty
    }
    
    mutating func enqueue(with data: T) {
        queue[tail] = data
        tail += 1
    }
    
    mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        }
        let value = queue[head]
        queue[head] = nil
        head += 1
        return value
    }
    
    mutating func reset() {
        queue = [:]
        head = 0
        tail = 0
    }
}

struct Formula {
    var operands = CalculatorItemQueue<Double>()
    var operators = CalculatorItemQueue<Operator>()
    
    mutating func result() throws -> Double {
        var lhs = operands.dequeue() ?? 0.0
        while operators.isEmpty == false {
            let rhs = operands.dequeue() ?? 0.0
            let oneOperator = operators.dequeue() ?? Operator.add
            if oneOperator == .divide && rhs == 0.0 {
                throw CalculatorError.dividedWithZero
            } else {
                lhs = oneOperator.calculate(lhs: lhs, rhs: rhs)
            }
        }
        return lhs
    }
}
