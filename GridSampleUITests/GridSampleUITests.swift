//
//  GridSampleUITests.swift
//  GridSampleUITests
//
//  Created by Alexandr_Ostrovskiy on 19.07.2022.
//

import XCTest

class GridSampleUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGridsItemTap() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertEqual(app.cells.count, 9)
        
        let centerIndex = app.collectionViews.children(matching: .cell).count - 5
        
        let currentSize = app.collectionViews.cells.element(boundBy: centerIndex).frame.size
        let rightSize = CGSize(width: currentSize.width + 80, height: currentSize.height + 80)
        
        let centerCell = app.collectionViews.cells.element(boundBy: centerIndex)
        
        XCTAssertTrue(centerCell.staticTexts["Look 5"].exists)
        
        centerCell.tap()
        
        XCTAssertEqual(centerCell.frame.size, rightSize)
        
        XCTAssertTrue(centerCell.staticTexts["Some additional info"].exists)
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
