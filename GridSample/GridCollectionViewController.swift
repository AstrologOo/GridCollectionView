//
//  GridCollectionViewController.swift
//  GridSample
//
//  Created by Alexandr_Ostrovskiy on 22.07.2022.
//

import UIKit

class GridCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        collectionView.contentInset = UIEdgeInsets(top: 40, left: 8, bottom: 40, right: 8)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func cellPinchAction(_ sender: GridCollectionViewCell.GridPinchGestureRecognizer) {
        if sender.numberOfTouches != 2 { return }
        
        guard let layout = collectionViewLayout as? GridCollectionViewLayout else { return }
        
        guard let cell = sender.view else { return }
        
        let p1 = sender.location(ofTouch: 0, in: cell)
        let p2 = sender.location(ofTouch: 1, in: cell)
        
        let xd = p1.x - p2.x
        let yd = p1.y - p2.y
        
        let bearingAngle = yd == 0 ? CGFloat.pi / 2.0 : abs(atan(xd/yd))
        
        var newSize = cell.frame.size
        
        if bearingAngle < CGFloat.pi / 6.0 {
            newSize.height += sender.velocity
        } else if bearingAngle < CGFloat.pi / 3.0 {
            newSize.height += sender.velocity
            newSize.width += sender.velocity
        } else if bearingAngle <= CGFloat.pi / 2.0 {
            newSize.width += sender.velocity
        }

        layout.changeItemSize(indexPath: sender.indexPath, size: newSize)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 50
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCollectionViewCell.reuseIdentifier, for: indexPath) as! GridCollectionViewCell
        
        cell.label.text = "Sec \(indexPath.section)/Item \(indexPath.item)"
        
        let pinch = GridCollectionViewCell.GridPinchGestureRecognizer(target: self, action: #selector(cellPinchAction(_:)), indexPath: indexPath)
        cell.addGestureRecognizer(pinch)
    
        return cell
    }
}
