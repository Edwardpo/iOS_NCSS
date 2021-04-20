//
//  NetworkClientTests.swift
//  NCSSTests
//
//  Created by Edward Poon on 4/17/21.
//

import XCTest
@testable import NCSS

class NetworkClientTests: XCTestCase {
    
    var sut: NetworkClient!

    override func setUpWithError() throws {
        sut = NetworkClient()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testNetworkClient_init_usesSharedSession() {
        XCTAssertEqual(sut.session, URLSession.shared, "Default session should be the shared session \(sut.session) != \(URLSession.shared)")
    }
    
    func testNetworkClient_canChangeSession() {
        let ephemeralSession = URLSession.init(configuration: .ephemeral)
        sut.session = ephemeralSession
        XCTAssertNotEqual(sut.session, URLSession.shared)
        XCTAssertEqual(sut.session, ephemeralSession)
    }
    
    func testNetworkClient_whenGetData_urlSessionResumeCalled() {
        givenUsesMockSession()
        
        let url = URL(string: "https://example.com")!
        sut.loadData(from: url, completionHandler: nil)
        if let mockSession = sut.session as? MockURLSession {
            XCTAssertTrue(mockSession.mockDataTask.resumeCalled, "If loading data, should call resume")
        }
        else {
            XCTFail("mock session and/or data task were not set properly")
        }
    }
    
    func testNetworkClient_whenGetData_sendsToCorrectURL() {
        givenUsesMockSession()
        
        let url = URL(string: "https://example.com")!
        sut.loadData(from: url, completionHandler: nil)
        if let mockSession = sut.session as? MockURLSession {
            XCTAssertNotNil(mockSession.mockDataTask.url)
            XCTAssertEqual(mockSession.mockDataTask.url, url)
        }
        else {
            XCTFail("mock session and/or data task were not set properly")
        }
    }
    
    func testNetworkClient_whenSendData_urlSessionResumeCalled() {
        givenUsesMockSession()
        let url = URL(string: "https://example.com")!
        let objectToSend = MockObject(variable1: "Test1", variable2: 3)
        sut.sendData(to: url, body: objectToSend, completionHandler: nil)
        if let mockSession = sut.session as? MockURLSession {
            XCTAssertTrue(mockSession.mockDataTask.resumeCalled, "If sending data, should call resume")
        }
        else {
            XCTFail("mock session and/or data task were not set properly")
        }
    }
    
    func testNetworkClient_whenSendData_sendsToCorrectURL() {
        givenUsesMockSession()
        let url = URL(string: "https://example.com")!
        let objectToSend = MockObject(variable1: "Test1", variable2: 3)
        sut.sendData(to: url, body: objectToSend, completionHandler: nil)
        if let mockSession = sut.session as? MockURLSession {
            XCTAssertNotNil(mockSession.mockDataTask.urlRequest?.url)
            XCTAssertEqual(mockSession.mockDataTask.urlRequest?.url, url)
        }
        else {
            XCTFail("mock session and/or data task were not set properly")
        }
    }
    
    func testNetworkClient_whenSendData_sendsCorrectData() {
        givenUsesMockSession()
        let url = URL(string: "https://example.com")!
        let objectToSend = MockObject(variable1: "Test1", variable2: 3)
        
        sut.sendData(to: url, body: objectToSend, completionHandler: nil)
        do {
            if let mockSession = sut.session as? MockURLSession {
                let dataToSend = try JSONEncoder().encode(objectToSend)
                let dataSent = mockSession.mockDataTask.urlRequest?.httpBody
                XCTAssertNotNil(dataSent)
                XCTAssertEqual(dataToSend, dataSent)
            }
            else {
                XCTFail("mock session and/or data task were not set properly")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    func givenUsesMockSession() {
        let mockSession = MockURLSession()
        let mockDataTask = MockDataTask()
        mockSession.mockDataTask = mockDataTask
        sut.session = mockSession
    }
}
