//
//  AlarmPopUpViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/10.
//

import UIKit

import SnapKit
import Then

final class AlarmPopUpViewController: UIViewController {

    // MARK: - Properties
    
    private var lightningView = PopUpView()
    
    private var cancelView = CancelView().then {
        $0.backgroundColor = .white
        $0.isHidden = true
    }
    
    var lightningName: String = "" {
        didSet {
            lightningView.lightningName = lightningName
        }
    }
    var groupName: String = "" {
        didSet {
            lightningView.groupName = groupName
        }
    }
    var member: String = "" {
        didSet {
            lightningView.groupName = "\(groupName) \(member)"
        }
    }
    var memberCount: Int = 0 {
        didSet {
            lightningView.memberCount = memberCount
        }
    }
    var location: String = "" {
        didSet {
            lightningView.location = location
        }
    }
    var date: String = "" {
        didSet {
            lightningView.date = date
        }
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        bind()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    private func setLayout() {
        view.addSubviews([lightningView, cancelView])
        
        lightningView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(222)
            $0.leading.trailing.equalToSuperview().inset(42)
            $0.height.equalTo(390)
        }
        
        cancelView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(268)
            $0.leading.trailing.equalToSuperview().inset(42)
            $0.height.equalTo(256)
        }
    }
    
    private func bind() {
        lightningView.delegate = self
        cancelView.delegate = self
    }
    
    // MARK: - Custom Method
    
    internal func handleTap(alarmType: AlarmItemType) {
        switch alarmType {
        case .thunder:
            lightningView.isHidden = false
            cancelView.isHidden = true
        case .lightning:
            lightningView.isHidden = false
            cancelView.isHidden = true
        case .cancel:
            lightningView.isHidden = true
            cancelView.isHidden = false
        }
    }
}

// MARK: - Custom Delegate

extension AlarmPopUpViewController: PopUpViewDelegate, CancelViewDelegate {
    func touchUpCancelButton() {
        dismiss(animated: true)
    }
    
    func touchUpJoinButton() {
        NotificationCenter.default.post(name: NSNotification.Name("Join"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(Const.Notification.join), object: nil)
        dismiss(animated: true)
    }
    
    func touchUpConfirmButton() {
        dismiss(animated: true)
    }
}
