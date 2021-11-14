//
//  CalculatorItemQueue.swift
//  Calculator
//
//  Created by 이승재 on 2021/11/09.
//

import Foundation

struct CalculatorItemQueue<Element: CalculatorItem> {
    private var items: LinkedList<Element>
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    init() {
        items = LinkedList<Element>()
    }
    
    mutating func enqueue(_ item: Element) {
        items.append(item)
    }
    
    mutating func dequeue() -> Element? {
        return items.pop()
    }
    
    mutating func removeLast() -> Element? {
        return items.removeLast()
    }
}

extension CalculatorItemQueue: CustomStringConvertible {
    var description: String {
        return items.description
    }
}

