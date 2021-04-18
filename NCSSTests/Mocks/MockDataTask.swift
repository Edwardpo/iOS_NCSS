//
//  MockDataTask.swift
//  NCSSTests
//
//  Created by Edward Poon on 4/17/21.
//

import Foundation

class MockDataTask: URLSessionDataTask {
    var resumeCalled: Bool = false
    var urlRequest: URLRequest?
    var url: URL?
    
    override func resume() {
        resumeCalled = true
    }
}
