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
        dismiss(animated: true, completion: nil)
        dismiss(animated: true)
    }
    
    func touchUpConfirmButton() {
        dismiss(animated: true)
    }
}

// MARK: - Cancel Pop Up View

protocol CancelViewDelegate: AnyObject {
    func touchUpConfirmButton()
}

fileprivate final class CancelView: UIView {
    
    // MARK: - Properties
    
    private var alarmIconImageView = UIImageView().then {
        $0.backgroundColor = .yellow200
    }
    
    private var lightningNameLabel = UILabel().then {
        $0.text = "번개이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 16)
    }
    
    private var groupNameLabel = UILabel().then {
        $0.text = "[그룹이름]주최자이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = .gray350
    }
    
    private var contentLabel = UILabel().then {
        $0.text = "이태원 모각작 모아요 번개 정원이 충족되지 않았습니다"
        $0.setTextSpacingBy(value: -0.6)
        $0.numberOfLines = 0
        $0.textColor = .gray100
        $0.textAlignment = .center
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
    }
    
    private lazy var confirmButton = UIButton().then {
        $0.backgroundColor = .purple100
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(touchUpConfirmButton), for: .touchUpInside)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 13)
        $0.titleLabel?.setTextSpacingBy(value: -0.6)
    }
    
    weak var delegate: CancelViewDelegate?
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .white
        
        makeRounded(cornerRadius: 8)
        
        confirmButton.makeRounded(cornerRadius: 8)
        confirmButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    private func setLayout() {
        addSubviews([alarmIconImageView, lightningNameLabel, groupNameLabel, lineView, contentLabel, confirmButton])
        
        alarmIconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(26)
            $0.width.height.equalTo(30)
            $0.centerX.equalToSuperview()
        }
        
        lightningNameLabel.snp.makeConstraints {
            $0.top.equalTo(alarmIconImageView.snp.bottom).offset(13)
            $0.centerX.equalToSuperview()
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(lightningNameLabel.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(13)
            $0.height.equalTo(1)
            $0.width.equalTo(251)
            $0.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(29)
            $0.height.equalTo(40)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(208)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpConfirmButton() {
        delegate?.touchUpConfirmButton()
    }
}
