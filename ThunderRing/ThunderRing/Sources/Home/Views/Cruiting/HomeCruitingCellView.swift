//
//  HomeRecruitingView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/09.
//

import UIKit

import SnapKit
import Then

final class HomeCruitingCellView: UIView {

    // MARK: - Properties
    
    private lazy var contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.spacing = 0
    }
    
    private lazy var backgroudView = UIView().then {
        $0.backgroundColor = .gray350
    }
    
    private lazy var countLabelView = CountLabelView()
    
    private lazy var locationImageView = UIImageView().then {
        $0.image = UIImage(named: "icnLocation")
    }
    
    private lazy var subtitleLabel = UILabel().then {
        $0.text = "번개정보"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "[그룹명] 번개명"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var imageStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.spacing = 6
    }
    
    var members: [String] = ["김씨", "박씨"]
    
    private lazy var itemViews: [UIView] = members.map { data in
        let view = MemberImageView(memberType: .participant)
        return view
    }
    
    private lazy var itemView: [UIView] = members[0].map { data in
        let view = MemberImageView(memberType: .promoter)
        return view
    }
    
    // MARK: - Initialzers
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
        
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(backgroudView)
        contentStackView.addArrangedSubview(countLabelView)
        
        backgroudView.addSubviews([locationImageView,
                                   subtitleLabel,
                                   titleLabel,
                                   imageStackView])
        
        for view in itemViews {
            imageStackView.addArrangedSubview(view)
        }
    }
    
    private func setLayout() {
        backgroudView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.top.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview()
        }
        
        countLabelView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(45)
            $0.width.equalTo(98)
            $0.height.equalTo(31)
        }
        
        locationImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(19)
            $0.top.equalToSuperview().inset(36)
            $0.width.equalTo(10)
            $0.height.equalTo(15)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(locationImageView.snp.centerY)
            $0.leading.equalTo(locationImageView.snp.trailing).offset(5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(19)
        }
        
        imageStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(17)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    // MARK: - Custom Method
}

// MARK: - Custom View

fileprivate final class CountLabelView: UIView {
    
    var count: Int = 0 {
        didSet {
            titleLabel.text = "잔여 \(count)자리"
        }
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
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
        backgroundColor = .purple100
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

// MARK: - Member

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

fileprivate final class MemberImageView: UIImageView {
    private lazy var type: MemberType = .promoter
    
    private lazy var iconImageView = UIImageView().then {
        $0.image = type.image
    }
    
    init(memberType: MemberType) {
        super.init(frame: .zero)
        self.type = memberType
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configUI() {
        clipsToBounds = false
        image = type.image
        makeRounded(cornerRadius: 15)
        
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(32)
            $0.leading.equalToSuperview().inset(33)
            $0.width.height.equalTo(22)
        }
    }
}
