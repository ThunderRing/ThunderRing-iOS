//
//  MemberTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/04.
//

import UIKit

import SnapKit
import Then

final class MemberTableViewCell: UITableViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private var userImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 17, bounds: true)
        $0.isHidden = false
    }
    
    private var defaultView = DefaultContactView(text: "김").then {
        $0.isHidden = true
    }
    
    private var userNameLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var phoneNumberLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .DINPro(type: .regular, size: 14)
    }
    
    private var checkButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnCheckIn"), for: .normal)
        $0.isHidden = true
    }

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            checkButton.setImage(UIImage(named: "btnCheck"), for: .normal)
        } else {
            checkButton.setImage(UIImage(named: "btnCheckIn"), for: .normal)
        }
    }
    
    // MARK: - Custom Method
    
    private func configUI() {
        backgroundColor = .white
        initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 1, bounds: true)
    }
    
    private func setLayout() {
        addSubviews([userImageView, defaultView, userNameLabel, phoneNumberLabel, checkButton])
        
        userImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(18)
            $0.width.equalTo(48)
            $0.height.equalTo(50)
        }
        
        defaultView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(18)
            $0.width.equalTo(48)
            $0.height.equalTo(50)
        }
        
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(userImageView.snp.trailing).offset(15)
            $0.top.equalToSuperview().inset(22)
        }
        
        phoneNumberLabel.snp.makeConstraints {
            $0.leading.equalTo(userImageView.snp.trailing).offset(15)
            $0.top.equalTo(userNameLabel.snp.bottom).offset(1)
        }
        
        checkButton.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    internal func initCell(_ data: ContactData) {
        userNameLabel.text = data.name
        phoneNumberLabel.text = data.number
    
        if data.isUser {
            userImageView.image = UIImage(named: data.profileImageName)
            
            checkButton.isHidden = false
            
            defaultView.isHidden = true
        } else {
            userImageView.isHidden = true
            
            checkButton.isHidden = true
            
            defaultView.text = "\(data.name[data.name.index(data.name.startIndex, offsetBy: 0)])"
            defaultView.isHidden = false
        }
    }
}

// MARK: - View

fileprivate final class DefaultContactView: UIView {
    
    var text: String = "" {
        didSet {
            textLabel.text = text
        }
    }
    
    private var textLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    // MARK: - Initializer
    
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 17, bounds: true)
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
