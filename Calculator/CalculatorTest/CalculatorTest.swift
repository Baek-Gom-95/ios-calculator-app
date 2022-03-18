//
//  CalculatorTest.swift
//  CalculatorTest
//
//  Created by song on 2022/03/15.
//

import XCTest
@testable import Calculator

final class CalculatorTests: XCTestCase {
  var sut: CalculateItemQueue<Double>!
  var sut1: ExpressionParser!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = CalculateItemQueue()
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    sut = nil
  }
  
  func test_enqueue함수를_호출하면_1이_추가되는지() {
    let input = 1.0
    
    sut.enqueue(data: input)
    
    XCTAssertEqual(sut.list.head?.data, 1.0)
  }
  
  func test_enqueue함수를_호출하면_2가_올라가는지() {
    let input = 2.0
    
    sut.enqueue(data: input)
    
    XCTAssertEqual(sut.list.head?.data, 2.0)
  }
  
  func test_dequeue함수를_호출하면_올라갔던_2가_삭제되는지() {
    let input = 2.0
    let input3 = 3.0
    sut.enqueue(data: input)
    sut.enqueue(data: input3)

    
    XCTAssertEqual(sut.dequeue(), 2.0)
  }
  
  func test_dequeue함수를_호출하면_올라갔던_1과2중_1이_삭제되는지() {
    let inputOne = 1.0
    let inputTwo = 2.0
    
    sut.enqueue(data: inputOne)
    sut.enqueue(data: inputTwo)
    sut.dequeue()
    
    XCTAssertEqual(sut.list.head?.data, 2.0)
  }
  
  func test_dequeueAll함수를_호출하면_올라갔던_1과2가_삭제되는지() {
    let inputOne = 1.0
    let inputTwo = 2.0
    
    sut.enqueue(data: inputOne)
    sut.enqueue(data: inputTwo)
    sut.dequeueAll()
    
    XCTAssertEqual(sut.presentAll(), [])
  }
  
  func test_presentAll함수를_호출하면_올라갔던_1과2가_모두보이는지() {
    let inputOne = 1.0
    let inputTwo = 2.0
    
    sut.enqueue(data: inputOne)
    sut.enqueue(data: inputTwo)
    
    XCTAssertEqual(sut.presentAll(), [1.0, 2.0])
  }
  
  func test_dequeueLatest함수를_호출하면_올라갔던_1과2중_2가_삭제되는지() {
    let inputOne = 1.0
    let inputTwo = 2.0

    sut.enqueue(data: inputOne)
    sut.enqueue(data: inputTwo)
    sut.dequeueLatest()
    
    XCTAssertEqual(sut.presentAll(), [1.0])
  }
  
  func test_presentAll함수를_아무것도_없는_상태에서_호출하면_nil이_출력되는지() {
    XCTAssertEqual(sut.presentAll(), [])
  }
  
  func test_dequeue함수를_아무것도_없는_상태에서_호출하면_capacity가_0이되는지() {
    sut.dequeue()
    
    XCTAssertEqual(sut.list.capacity, 0)
  }
  
  func test_dequeue함수를_호출하면_올라갔던_1과2중_2가_반환되는지() {
    let inputOne = 1.0
    let inputTwo = 2.0

    sut.enqueue(data: inputOne)
    sut.enqueue(data: inputTwo)
    
    XCTAssertEqual(sut.dequeue(), 1.0)
  }
  
}
