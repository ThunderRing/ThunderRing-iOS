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
    
    private var popUpView = UIView().then {
        $0.backgroundColor = .white
    }

    var alarmType: AlarmType = .lightning {
        didSet {
            switch alarmType {
            case .thunder:
                popUpView.backgroundColor = .purple100
            case .lightning:
                popUpView.backgroundColor = .yellow100
            case .failed:
                popUpView.backgroundColor = .red
            }
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    private func setLayout() {
        view.addSubview(popUpView)
        popUpView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(222)
            $0.leading.trailing.equalToSuperview().inset(42)
            $0.bottom.equalToSuperview().inset(242)
        }
    }
    
    // MARK: - Custom Method
}
