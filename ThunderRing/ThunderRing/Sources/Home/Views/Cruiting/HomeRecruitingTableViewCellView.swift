//
//  HomeRecruitingView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/09.
//

import UIKit

import SnapKit
import Then

final class HomeRecruitingTableViewCellView: UIView {

    // MARK: - Properties
    
    private lazy var backgroudView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var countLabelView = CountLabelView()
    
    private lazy var locationImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_location")
    }
    
    private lazy var subtitleLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 12)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var memberStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.spacing = 12
    }
    
    private lazy var iconImageView = UIImageView().then {
        $0.image = UIImage(named: "icnPromoter")
    }
    
    private var memberCount: Int = 1
    private var data: LightningDataModel?
    
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
        
        backgroudView.initViewBorder(borderWidth: 1,
                                     borderColor: UIColor.gray350.cgColor,
                                     cornerRadius: 5,
                                     bounds: true)
        
        addSubviews([backgroudView, countLabelView])
        
        backgroudView.addSubviews([locationImageView,
                                   subtitleLabel,
                                   titleLabel,
                                   memberStackView,
                                   iconImageView])
    }
    
    private func setLayout() {
        backgroudView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.top.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        countLabelView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
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
        
        memberStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(17)
//            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(53)
            $0.leading.equalToSuperview().inset(50)
            $0.width.height.equalTo(22)
        }
    }
    
    // MARK: - Custom Method
    
    internal func configCell(lightning: LightningDataModel) {
        guard let count = lightning.members?.count else { return }
        memberCount = count
        
        guard let members = lightning.members else { return }
        memberStackView.updateMemberStackView(members: members)
        
        titleLabel.text = "\(lightning.groupName) \(lightning.lightningName)"
        subtitleLabel.text = "\(lightning.location) \(lightning.date) \(lightning.time)"
        
        countLabelView.count = lightning.maxNumber - lightning.minNumber
    }
}

// MARK: - Extension

extension UIStackView {
    func updateMemberStackView(members: [String]) {
        for member in members {
            self.addArrangedSubview(initImageView(memberImageName: member))
        }
        let plusButton = PlusButton()
        self.addArrangedSubview(plusButton)
    }
    
    private func initImageView(memberImageName: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: memberImageName)!
        imageView.makeRounded(cornerRadius: 15)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.height.equalTo(50)
        }
        return imageView
    }
}

// MARK: - Custom Component

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
        makeRounded(cornerRadius: 15.5)
    }
    
    private func setLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

fileprivate final class PlusButton: UIButton {
    private var plusImageView = UIImageView().then {
        $0.image = UIImage(named: "icn_plus")
    }
    
    init() {
        super.init(frame: .zero)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        addTarget(self, action: #selector(touchUpPlusButton), for: .touchUpInside)
        
        initViewBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 15, bounds: true)
        addSubview(plusImageView)
        plusImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.height.equalTo(18)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpPlusButton() {
        NotificationCenter.default.post(name: NSNotification.Name("TouchUpPlusButton"), object: nil)
    }
}

