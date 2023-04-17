//
//  BaseXCTestCase.swift
//  TCANetworkTests
//
//  Created by Adriano Rezena on 17/04/23.
//

import Foundation

func anyURL() -> URL {
    URL(string: "https://url.com")!
}

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 0)
}

func anyData() -> Data {
    Data("any data".utf8)
}
