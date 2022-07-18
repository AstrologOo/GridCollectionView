//
//  ViewController.swift
//  GridSample
//
//  Created by Alexandr_Ostrovskiy on 15.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var gridConfig: GridConfiguration!
    
    private lazy var dataService: DataServiceProtocol = DataService()
    
    private lazy var dataSource = makeDataSource()

    private var data: [SomeData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupCollectionView()
    }
    
    private func loadData() {
        self.data = dataService.getData()
    }

    
    private func setupCollectionView() {
        
        gridConfig = GridConfiguration(defaultSize: .zero, columnCount: 3, itemsCount: data.count)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        
        self.view.addSubview(collectionView)
        
        let widthPerItem = collectionView.frame.width / CGFloat(gridConfig.columnCount) - layout.minimumInteritemSpacing
        let squreSizeWidth = ceil(widthPerItem - 8)
        let size = CGSize(width: squreSizeWidth, height: squreSizeWidth)
        
        gridConfig.defaultSize = size
        
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        
        setData(animated: true)
    }
    
    private func setData(animated: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, SomeData>()
        snapshot.appendSections([0])
        
        snapshot.appendItems(data)
            
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    private func makeDataSource() -> UICollectionViewDiffableDataSource<Int, SomeData> {
               
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, SomeData> { [unowned self] cell, indexPath, movie in
            
            var content = UIListContentConfiguration.cell()
            content.text = data[indexPath.item].name
            
            if self.gridConfig.isSelectedIndex(indexPath.item) {
                content.secondaryText = data[indexPath.item].body
            }
            
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listPlainCell()
            background.cornerRadius = 10
            background.backgroundColor = .lightGray
            background.strokeWidth = 0.5
            background.strokeColor = .gray
            
            cell.backgroundConfiguration = background
        }
        
        return UICollectionViewDiffableDataSource<Int, SomeData>(
                    collectionView: collectionView,
                    cellProvider: { collectionView, indexPath, item in
                        collectionView.dequeueConfiguredReusableCell(
                            using: cellRegistration,
                            for: indexPath,
                            item: item
                        )
                    }
                )
    }
 
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gridConfig.setSelected(by: indexPath.item)
        
        var currentSnapshot = dataSource.snapshot()
        
        currentSnapshot.reconfigureItems(data)
        dataSource.apply(currentSnapshot)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                  layout collectionViewLayout: UICollectionViewLayout,
                  insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                   layout collectionViewLayout: UICollectionViewLayout,
                   sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return gridConfig.cellSizes[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


fileprivate struct GridConfiguration {
    var defaultSize: CGSize {
        didSet {
            calculateSizesForCells()
        }
    }
    
    var itemsCount: Int
    var columnCount: Int
    var cellSizes: [CGSize] = []
    
    // secelted row and column
    var selectedPoint: (r: Int, c: Int)? = nil
    
    var expandedHeightForRows: CGFloat = 80
    var expandedWidthForColumns: CGFloat = 80
    
    init(defaultSize: CGSize, columnCount: Int, itemsCount: Int) {
        self.defaultSize = defaultSize
        self.columnCount = columnCount
        self.itemsCount = itemsCount
        calculateSizesForCells()
    }
    
    mutating func calculateSizesForCells() {
        cellSizes = []
        cellSizes.append(contentsOf: repeatElement(defaultSize, count: itemsCount))
        
        guard let selectedPoint = self.selectedPoint else {
            return
        }
        
        for i in 0..<cellSizes.count {
            
            let index = i + 1
            
            let row = getRowByIndex(index)
            let column = getColumnByIndex(index)
            
            if selectedPoint.r == row {
                cellSizes[i].height += expandedHeightForRows
            }

            if selectedPoint.c == column {
                cellSizes[i].width += expandedWidthForColumns
            } else {
                cellSizes[i].width -= expandedWidthForColumns / CGFloat(columnCount - 1)
            }
        }
    }
    
    mutating func setSelected(by index: Int) {
        let row = getRowByIndex(index + 1)
        let column = getColumnByIndex(index + 1)
        selectedPoint = (r: row, c: column)
        calculateSizesForCells()
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
