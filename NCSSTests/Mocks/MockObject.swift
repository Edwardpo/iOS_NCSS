//
//  MockObject.swift
//  NCSSTests
//
//  Created by Edward Poon on 4/17/21.
//

import Foundation

class MockObject: Codable {
    var variable1: String
    var variable2: Int
    
    init(variable1: String, variable2: Int) {
        self.variable1 = variable1
        self.variable2 = variable2
    }
}
