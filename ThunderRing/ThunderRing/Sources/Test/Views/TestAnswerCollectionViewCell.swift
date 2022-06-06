//
//  TestAnswerCollectionViewCell.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/16.
//

import UIKit

import SnapKit
import Then

protocol TestAnswerCollectionViewCellDelegate: TendencyTestCollectionViewCell {
    func touchUpAnswer()
}

final class TestAnswerCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private lazy var textLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    var index: Int = 0
    var selectedAnswer: Int = 0
    
    var delegate: TestAnswerCollectionViewCellDelegate?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.purple100.cgColor
                layer.borderWidth = 2
                
                delegate?.touchUpAnswer()
                
                if index == 7 {
                    NotificationCenter.default.post(name: NSNotification.Name("LastTest"), object: nil)
                }
                
                if index == 3 {
                    if selectedAnswer == 0 {
                        NotificationCenter.default.post(name: NSNotification.Name("TestResultNoti"), object: "cozy")
                    } else if selectedAnswer == 1 {
                        NotificationCenter.default.post(name: NSNotification.Name("TestResultNoti"), object: "emotional")
                    } else if selectedAnswer == 2 {
                        NotificationCenter.default.post(name: NSNotification.Name("TestResultNoti"), object: "soft")
                    } else if selectedAnswer == 3 {
                        NotificationCenter.default.post(name: NSNotification.Name("TestResultNoti"), object: "diligent")
                    }
                }
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    // MARK: - Initializer
    
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
        self.backgroundColor = .gray350
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        addSubview(textLabel)
    }
    
    private func setLayout() {
        textLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Custom Method
    
    internal func initCell(text: String) {
        textLabel.text = text
        textLabel.setTextSpacingBy(value: -0.6)
    }
}

