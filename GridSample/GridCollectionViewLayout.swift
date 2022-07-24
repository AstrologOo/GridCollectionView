//
//  GridCollectionViewLayout.swift
//  GridSample
//
//  Created by Alexandr_Ostrovskiy on 22.07.2022.
//

import UIKit

class GridCollectionViewLayout: UICollectionViewLayout {
    
    let cellMinHeight = 60.0
    let cellMinWidth = 100.0
    
    var cellAttrsDictionary = Dictionary<IndexPath, UICollectionViewLayoutAttributes>()
    
    var contentSize = CGSize.zero
    
    
    var sectionsWidth: [Int: Double] = [:]
    
    override var collectionViewContentSize: CGSize {
        return self.contentSize
    }
    
    func changeItemSize(indexPath: IndexPath, size newSize: CGSize) {
        guard let collectionView = collectionView else { return }
        
        
        let section = indexPath.section
        let item = indexPath.item
        var newSize = newSize
        
        guard let currentAttributes = cellAttrsDictionary[indexPath] else { return }
        
        if newSize.width <= cellMinWidth {
            newSize.width = cellMinWidth
        }
        
        if newSize.height <= cellMinHeight {
            newSize.height = cellMinHeight
        }
        
        currentAttributes.size = newSize
        
        for section in 0...collectionView.numberOfSections - 1 {
            let index = IndexPath(item: item, section: section)

            cellAttrsDictionary[index]?.size.width = newSize.width
        }
        
        for item in 0...collectionView.numberOfItems(inSection: section) - 1 {
            let index = IndexPath(item: item, section: section)

            cellAttrsDictionary[index]?.size.height = newSize.height
        }
        
        invalidateLayout()
    }

    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        var contentWidth: Double = 0
        var contentHeight: Double = 0
        
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                
                let cellIndex = IndexPath(item: item, section: section)
                let previousIndex = IndexPath(item: item - 1, section: section)
                let higherIndex = IndexPath(item: item, section: section - 1)
                
                
                var height = cellMinHeight
                var width = cellMinWidth
                var xPos = Double(item) * width
                var yPos = Double(section) * height
                
                
                if let currentAttributes = cellAttrsDictionary[cellIndex] {
                    xPos = currentAttributes.frame.origin.x
                    yPos = currentAttributes.frame.origin.y
                    height = currentAttributes.size.height
                    width = currentAttributes.size.width
                }
                
                if let previousAttributes = cellAttrsDictionary[previousIndex] {
                    xPos = previousAttributes.frame.origin.x + previousAttributes.frame.width
                }
                
                if let higherAttributes = cellAttrsDictionary[higherIndex] {
                    yPos = higherAttributes.frame.origin.y + higherAttributes.frame.height
                }
                
                if cellIndex.item == 0 {
                    xPos = 0
                }
                
                let cellAttributes = UICollectionViewLayoutAttributes(forCellWith: cellIndex)
                cellAttributes.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
                
                if section == 0 && item == 0 {
                    cellAttributes.zIndex = 4
                } else if section == 0 {
                    cellAttributes.zIndex = 3
                } else if item == 0 {
                    cellAttributes.zIndex = 2
                } else {
                    cellAttributes.zIndex = 1
                }
                
                cellAttrsDictionary[cellIndex] = cellAttributes
                
                if item == 0 {
                    contentHeight += height
                }
                
                if section == 0 {
                    contentWidth += width
                }
            }
        }

        self.contentSize = CGSize(width: contentWidth, height: contentHeight)
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesInRect = [UICollectionViewLayoutAttributes]()
        
        for cellAttributes in cellAttrsDictionary.values {
            if rect.intersects(cellAttributes.frame) {
                attributesInRect.append(cellAttributes)
            }
        }
        
        return attributesInRect
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttrsDictionary[indexPath]!
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
    
    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        return false
    }
    
}
