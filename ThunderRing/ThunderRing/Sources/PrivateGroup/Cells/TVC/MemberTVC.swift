//
//  MemberTVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/04.
//

import UIKit
import SnapKit
import Then

class MemberTVC: UITableViewCell {
    static let identifier = "MemberTVC"
    
    // MARK: - UI
    
    private var userImageView = UIImageView().then {
        $0.image = UIImage(named: "icnUser")
    }
    
    private var userNameLabel = UILabel().then {
        $0.text = "이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var phoneNumberLabel = UILabel().then {
        $0.text = "010-1234-5678"
        $0.textColor = .gray100
        $0.font = .DINPro(type: .regular, size: 14)
    }
    
    private var checkButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnCheckIn"), for: .normal)
    }

    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initUI()
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
}

extension MemberTVC {
    private func initUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        addSubviews([userImageView, userNameLabel, phoneNumberLabel, checkButton])
        
        userImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(55)
            $0.height.equalTo(48)
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
            $0.trailing.equalToSuperview().inset(23)
            $0.centerY.equalToSuperview()
        }
    }
}

extension MemberTVC {
    func initCell(contact: ContactDataModel) {
        userNameLabel.text = contact.familyName + contact.givenName
        phoneNumberLabel.text = contact.phoneNumber
    }
    
    func setUserImage(index: Int) {
        switch index {
        case 0:
            self.userImageView.image = UIImage(named: "tendencyEmotion")
        case 1:
            self.userImageView.image = UIImage(named: "tendencySoft")
        case 2:
            self.userImageView.image = UIImage(named: "tendencyCrowd")
        case 3:
            self.userImageView.image = UIImage(named: "tendencyCozy")
        case 4:
            self.userImageView.image = UIImage(named: "tendencyDiligent")
        default :
            // FIXME: - empty icon으로 설정 
            self.userImageView.image = UIImage(named: "mypageIn")
        }
    }
}
