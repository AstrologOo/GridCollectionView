//
//  GridCollectionViewCell.swift
//  GridSample
//
//  Created by Alexandr_Ostrovskiy on 22.07.2022.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "cell"
    
    @IBOutlet weak var label: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        contentView.backgroundColor = .white
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 5.0
    }
    
    class GridPinchGestureRecognizer: UIPinchGestureRecognizer {
        var indexPath: IndexPath
        
        init(target: Any?, action: Selector?, indexPath: IndexPath) {
            self.indexPath = indexPath
            
            super.init(target: target, action: action)
        }
    }
}
