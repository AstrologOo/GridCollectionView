//
//  GridZiseCalculatorProtocol.swift
//  GridSample
//
//  Created by Alexandr_Ostrovskiy on 19.07.2022.
//

import UIKit


protocol ExpandedGridSizeCalculator {
    
    var columnCount: Int { get set }
    
    var defaultSize: CGSize { get set }
    
    var itemsCount: Int { get set }
    
    var itemSizes: [CGSize] { get set }
    
    var expandedHeightForRows: CGFloat { get set }
    
    var expandedWidthForColumns: CGFloat { get set }
    
    func calculateSizesForItem()
    
    func setSelected(by index: Int)
    
    func isSelectedIndex(_ index: Int) -> Bool
}

class SquareExpandedGridSizeCalculator: ExpandedGridSizeCalculator {
    var defaultSize: CGSize
    
    var itemsCount: Int
    var columnCount: Int
    var itemSizes: [CGSize] = []
    
    // secelted row and column
    
    var expandedHeightForRows: CGFloat = 80
    var expandedWidthForColumns: CGFloat = 80
    
    private var selectedPoint: (r: Int, c: Int)? = nil
    
    init(defaultSize: CGSize, columnCount: Int, itemsCount: Int) {
        self.defaultSize = defaultSize
        self.columnCount = columnCount
        self.itemsCount = itemsCount
        calculateSizesForItem()
    }
    
    func calculateSizesForItem() {
        itemSizes = []
        itemSizes.append(contentsOf: repeatElement(defaultSize, count: itemsCount))
        
        guard let selectedPoint = self.selectedPoint else {
            return
        }
        
        for i in 0..<itemSizes.count {
            
            let index = i + 1
            
            let row = getRowByIndex(index)
            let column = getColumnByIndex(index)
            
            if selectedPoint.r == row {
                itemSizes[i].height += expandedHeightForRows
            }

            if selectedPoint.c == column {
                itemSizes[i].width += expandedWidthForColumns
            } else {
                itemSizes[i].width -= expandedWidthForColumns / CGFloat(columnCount - 1)
            }
        }
    }
    
    func setSelected(by index: Int) {
        let row = getRowByIndex(index + 1)
        let column = getColumnByIndex(index + 1)
        selectedPoint = (r: row, c: column)
        calculateSizesForItem()
    }
    
    func isSelectedIndex(_ index: Int) -> Bool {
        guard let selectedPoint = self.selectedPoint else { return false }
        let row = getRowByIndex(index + 1)
        let column = getColumnByIndex(index + 1)
        return selectedPoint == (r: row, c: column)
    }
    
    private func getRowByIndex(_ index: Int) -> Int {
        let value = Double(index) / Double(columnCount)
        return Int(ceil(value)) - 1
    }
    
    private func getColumnByIndex(_ index: Int) -> Int {
        var column =  index % columnCount
        if column == 0 {
            return columnCount - 1
        }

        column -= 1
        
        return column
    }
}
