//
//  SomeData.swift
//  GridSample
//
//  Created by Alexandr_Ostrovskiy on 16.07.2022.
//

import Foundation

struct SomeData: Hashable {
    var name: String
    var body: String
    
    init(name: String, body: String = "No data") {
        self.name = name
        self.body = body
    }
    
    func hash(into hasher: inout Hasher) {
        return hasher.combine(name)
    }
    
    static func == (lhs: SomeData, rhs: SomeData) -> Bool {
        return lhs.name == rhs.name
    }
}
