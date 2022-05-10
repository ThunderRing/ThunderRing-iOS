//
//  TestResultTendencyView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/05/11.
//

import UIKit

import SnapKit
import Then

final class TestResultTendencyView: UIView {
    
    var type: TendencyType = .cozy {
        didSet {
            switch type {
            case .cozy:
                imageView.image = UIImage(named: "tendencyCozy")
                tendencyView.tagType = .cozy
                updateLayout(type: .cozy)
            case .crowd:
                imageView.image = UIImage(named: "tendencyCrowd")
                tendencyView.tagType = .crowd
                updateLayout(type: .crowd)
            case .diligent:
                imageView.image = UIImage(named: "tendencyDiligent")
                tendencyView.tagType = .diligent
                updateLayout(type: .diligent)
            case .emotion:
                imageView.image = UIImage(named: "tendencyEmotion")
                tendencyView.tagType = .emotion
                updateLayout(type: .emotion)
            case .soft:
                imageView.image = UIImage(named: "tendencySoft")
                tendencyView.tagType = .soft
                updateLayout(type: .soft)
            }
        }
    }
    
    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var tendencyView = GroupTendencyView(tagType: type).then {
        $0.makeRounded(cornerRadius: 3)
    }
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        
    }
    
    private func setLayout() {
        addSubviews([imageView, tendencyView])
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(27)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(69.1)
            $0.height.equalTo(61)
        }
        
        tendencyView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(12)
            $0.width.equalTo(84)
            $0.height.equalTo(21)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func updateLayout(type: TendencyType) {
        switch type {
        case .cozy:
            tendencyView.snp.updateConstraints {
                $0.width.equalTo(84)
            }
        case .crowd:
            tendencyView.snp.updateConstraints {
                $0.width.equalTo(84)
            }
        case .diligent:
            tendencyView.snp.updateConstraints {
                $0.width.equalTo(95)
            }
        case .emotion:
            tendencyView.snp.updateConstraints {
                $0.width.equalTo(95)
            }
        case .soft:
            tendencyView.snp.updateConstraints {
                $0.width.equalTo(84)
            }
        }
    }
}
