//
//  HomeCruitingCollectionViewCell.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/10.
//

import UIKit

import SnapKit
import Then

final class HomeRecruitingCollectionViewCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Initialzier
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        
    }
    
    private func setLayout() {
        
    }
}

// MARK: - Cell View

fileprivate final class HomeRecruitingCollectionViewCellView: UIView {

    fileprivate enum MemberType {
        case promoter
        case participant
        
        var image: UIImage {
            switch self {
            case .promoter:
                return UIImage(named: "icnPromoter")!
            case .participant:
                return UIImage(named: "chat")!
            }
        }
    }
    
    private var memberTpye: MemberType = .participant
    
    init(memberType: MemberType) {
        super.init(frame: .zero)
        self.memberTpye = memberType
        configUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        
    }
    
    private func setLayout() {
        
    }
}

