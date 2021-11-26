//
//  SelectTimeVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/27.
//

import UIKit

class SelectTimeVC: UIViewController {

    // MARK: - UI
    
    private lazy var backView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var topView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var completeButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.purple100, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 15)
    }
    
    private lazy var timePicker = UIDatePicker().then {
        $0.preferredDatePickerStyle = .wheels
        $0.datePickerMode = .time
        $0.locale = Locale(identifier: "ko")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setLayout()
        setAction()
    }
    
}

extension SelectTimeVC {
    private func initUI() {
        view.backgroundColor = UIColor(red: 0.0 / 255.0 , green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 0.5)
    }
    
    private func setLayout() {
        view.addSubviews([backView])
        backView.addSubviews([topView, completeButton, timePicker])
        
        backView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(255)
        }
        
        topView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        completeButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        timePicker.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(topView.snp.bottom)
        }
    }
    
    private func setAction() {
        completeButton.addAction(UIAction(handler: { _ in
            NotificationCenter.default.post(name: NSNotification.Name("SelectedTime"), object: self.timePicker.date)
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
    }
}
