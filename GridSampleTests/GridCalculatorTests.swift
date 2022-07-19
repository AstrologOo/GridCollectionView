//
//  GridCalculatorTests.swift
//  GridSampleTests
//
//  Created by Alexandr_Ostrovskiy on 19.07.2022.
//

import XCTest
@testable import GridSample

class GridCalculatorTests: XCTestCase {
    
    var gridSizeCalculator: ExpandedGridSizeCalculator!

    override func setUpWithError() throws {
        gridSizeCalculator = SquareExpandedGridSizeCalculator(defaultSize: CGSize(width: 100, height: 100), columnCount: 3, itemsCount: 9)
        gridSizeCalculator.expandedHeightForRows = 50
        gridSizeCalculator.expandedWidthForColumns = 50
    }

    override func tearDownWithError() throws {
        gridSizeCalculator = nil
    }

    func testSquareGridCalculator() throws {
        gridSizeCalculator.setSelected(by: 4)
        
        XCTAssertEqual(gridSizeCalculator.itemSizes, [
            CGSize(width: 75, height: 100),
            CGSize(width: 150, height: 100),
            CGSize(width: 75, height: 100),
            CGSize(width: 75, height: 150),
            CGSize(width: 150, height: 150),
            CGSize(width: 75, height: 150),
            CGSize(width: 75, height: 100),
            CGSize(width: 150, height: 100),
            CGSize(width: 75, height: 100)
        ])
    }
}
