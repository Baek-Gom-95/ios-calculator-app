//
//  ExpressionParserTests.swift
//  CalculatorTests
//
//  Created by marisolon 2022/03/19.
//

import XCTest
@testable import Calculator

class ExpressionParserTests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_parse의input에_string을넣고_dequeue하면_Double로변환된숫자가리턴된다() throws {
        // given
        let input = "1 + 2 + 3"
        // when
        var result = ExpressionParser.parse(from: input)
        // then
        XCTAssertEqual(result.operands.dequeue(), 1.0)
        XCTAssertEqual(result.operands.dequeue(), 2.0)
        XCTAssertEqual(result.operands.dequeue(), 3.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
