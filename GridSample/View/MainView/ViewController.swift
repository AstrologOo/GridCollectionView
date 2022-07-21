//
//  ViewController.swift
//  GridSample
//
//  Created by Alexandr_Ostrovskiy on 15.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var gridConfig: ExpandedGridSizeCalculator!
    
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
        
        gridConfig = SquareExpandedGridSizeCalculator(defaultSize: .zero, columnCount: 3, itemsCount: data.count)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        self.view.addSubview(collectionView)
        
        let contentWidth = collectionView.frame.width - 16
        let widthPerItem = contentWidth / CGFloat(gridConfig.columnCount)
        let squreSizeWidth = (widthPerItem).rounded(.down)
        let size = CGSize(width: squreSizeWidth, height: squreSizeWidth)
        
        gridConfig.defaultSize = size
        gridConfig.calculateSizesForItem()
        
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
            background.backgroundColor = .white
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
                   sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return gridConfig.itemSizes[indexPath.item]
    }
}
