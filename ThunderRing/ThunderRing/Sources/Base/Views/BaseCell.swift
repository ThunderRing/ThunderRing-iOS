//
//  BaseCell.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/04.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func initUI() {
        
    }
}
