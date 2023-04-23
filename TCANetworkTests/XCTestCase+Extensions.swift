//
//  XCTestCase+Extensions.swift
//  TCANetworkTests
//
//  Created by Adriano Rezena on 22/04/23.
//

import XCTest
import Foundation

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
