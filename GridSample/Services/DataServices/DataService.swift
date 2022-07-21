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
            SomeData(name: "Look 2", body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            SomeData(name: "Look 3", body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."),
            SomeData(name: "Look 4", body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            SomeData(name: "Look 5", body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry"),
            SomeData(name: "Look 6", body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            SomeData(name: "Look 7", body: "Some additional info"),
            SomeData(name: "Look 8", body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            SomeData(name: "Look 9", body: "Some additional info"),
            SomeData(name: "Look 90", body: "Some additional info"),
            SomeData(name: "Look 40", body: "Some additional info"),
        ]
    }
}
