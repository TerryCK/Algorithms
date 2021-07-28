//
//  CombineTestsTests.swift
//  CombineTestsTests
//
//  Created by Terry Chen on 2021/7/28.
//

import XCTest

@testable import CombineTests

import Combine
class ViewModel {
    private let valueSubject = CurrentValueSubject<Int, Never>(0)
    
    var valuePublisher: AnyPublisher<String, Never> {
        valueSubject.map { value in
            "\(value)"
        }.eraseToAnyPublisher()
    }
    
    func setValue(_ int: Int) {
        valueSubject.send(int)
    }
}

class CombineTestsTests: XCTestCase {
    
    func testExample() throws {
        let viewMode = ViewModel()
        let spy = ValueSpy(viewMode.valuePublisher)
        XCTAssertEqual(spy.values, ["0"])
        
        viewMode.setValue(1)
        
        XCTAssertEqual(spy.values, ["0", "1"])
    }
}

private class ValueSpy<Element> {
    private(set) var values = [Element]()
    
    private var cancellable: AnyCancellable?
    
    init(_ anyPublisher: AnyPublisher<Element, Never>) {
        cancellable = anyPublisher.sink { [weak self] value in
            self?.values.append(value)
        }
    }
}
