//
//  DataService.swift
//  GridSample
//
//  Created by Alexandr_Ostrovskiy on 16.07.2022.
//

import Foundation

class DataService: DataServiceProtocol {
    func getData() -> [SomeData] {
        return [
            SomeData(name: "Look!"),
            SomeData(name: "Look 2", body: "Some additional info"),
            SomeData(name: "Look 3", body: "Some additional info"),
            SomeData(name: "Look 4", body: "Some additional info"),
            SomeData(name: "Look 5", body: "Some additional info"),
            SomeData(name: "Look 6", body: "Some additional info"),
            SomeData(name: "Look 7", body: "Some additional info"),
            SomeData(name: "Look 8", body: "Some additional info"),
            SomeData(name: "Look 9", body: "Some additional info"),
        ]
    }
}
