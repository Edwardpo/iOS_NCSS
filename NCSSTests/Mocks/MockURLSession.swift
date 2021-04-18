//
//  MockURLSession.swift
//  NCSSTests
//
//  Created by Edward Poon on 4/17/21.
//

import Foundation

class MockURLSession: URLSession {
    var mockDataTask: MockDataTask!
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        mockDataTask.url = url
        return mockDataTask
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        mockDataTask.urlRequest = request
        return mockDataTask
    }
}
