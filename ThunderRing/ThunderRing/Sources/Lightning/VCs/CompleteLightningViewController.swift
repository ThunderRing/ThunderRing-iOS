//
//  CompleteLightningVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/11/24.
//

import UIKit

import SnapKit
import Then

final class CompleteLightningViewController: UIViewController {

    // MARK: - Properties
    
    private var contentImageView = UIImageView().then {
        $0.image = UIImage(named: "img_lightningComplete")
    }
    
    private var contentTextView = UIImageView().then {
        $0.image = UIImage(named: "text_lightningComplete")
    }
    
    private var contentLabel = UILabel().then {
        $0.text = "그룹원들에게 번개를 쳤어요\n1시간 뒤 천둥을 기대해보세요!"
        $0.setTextSpacingBy(value: -0.6)
        $0.setLineSpacing(lineSpacing: 7, lineHeightMultiple: 0)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    private lazy var confirmButton = TDSButton().then {
        $0.setTitleWithStyle(title: "확인", size: 16, weight: .medium)
        $0.isActivated = true
        $0.addTarget(self, action: #selector(touchUpConfirmButton), for: .touchUpInside)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .background
        setStatusBar(.background)
    }
    
    private func setLayout() {
        view.addSubviews([contentImageView, contentTextView, contentLabel, confirmButton])
        
        contentImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(110)
            $0.width.height.equalTo(270)
            $0.centerX.equalToSuperview()
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(contentImageView.snp.bottom).offset(27)
            $0.width.equalTo(180)
            $0.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(52)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpConfirmButton() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "a h시 mm분"
        let date = Calendar.current.date(byAdding: .hour, value: 1, to: Date())
        Const.Lightning.DateAndTime = dateFormatter.string(from: date!)
        dismiss(animated: true)
    }
}
