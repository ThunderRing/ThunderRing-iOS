//
//  MemberCVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/02.
//

import UIKit

import SnapKit
import Then

final class MemberCollectionViewCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private lazy var nameLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
        $0.textColor = .black
    }
    
    private lazy var cancelButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnDelete"), for: .normal)
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func setLayout() {
        contentView.addSubviews([nameLabel, cancelButton])
        contentView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 10, bounds: true)

        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(11)
        }
        
        cancelButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(280)
            $0.width.height.equalTo(48)
        }
    }
    
    internal func initCell(name: String) {
        nameLabel.text = name
        nameLabel.sizeToFit()
    }
}
