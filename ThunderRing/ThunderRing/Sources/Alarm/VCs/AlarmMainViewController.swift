//
//  AlarmMainViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/06.
//

import UIKit

import SnapKit
import Then

final class AlarmMainViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var navigationBar = TDSNavigationBar(self, view: .alarm, backButtonIsHidden: true, closeButtonIsHidden: true)
    
    private var contentScrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.isPagingEnabled = false
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    private var contentView = UIView()
    
    private var contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.spacing = 0
    }
    
    private var headerView = AlarmMainHeaderView()
    
    // MARK: - Item
    
    enum DataType {
        case text
        case view
    }
    
    struct Data {
        var type: DataType
        var value: [String]
        var alarmType: AlarmItemType?
        var isActive: Bool
    }
    
    private var dataList: [Data] = [
        Data(type: DataType.text, value: ["진행중인 알람"], isActive: false),
        Data(type: DataType.view, value: ["[러너] 한강 달리러 가실 분", "번개가 취소되었어요", "2"], alarmType: .cancel, isActive: true),
        Data(type: DataType.view, value: ["[양파링] 혜화역 혼가츠 먹자", "천둥이 울렸어요. 채팅을 볼까요?", "2"], alarmType: .thunder, isActive: true),
        Data(type: DataType.view, value: ["[라이딩] 한강 라이딩 하실 분 ", "번개가 도착했어요. 내용을 확인해보세요", "2"], alarmType: .lightning, isActive: true),
        Data(type: DataType.text, value: ["4월 8일"], isActive: false),
        Data(type: DataType.view, value: ["[러너] 한강 달리러 가실 분", "번개가 취소되었어요", "2"], alarmType: .cancel, isActive: false),
        Data(type: DataType.text, value: ["4월 6일"], isActive: false),
        Data(type: DataType.view, value: ["[러너] 한강 달리러 가실 분", "번개가 취소되었어요", "2"], alarmType: .cancel, isActive: false),
        Data(type: DataType.view, value: ["[러너] 한강 달리러 가실 분", "번개가 취소되었어요", "2"], alarmType: .thunder, isActive: false)
    ]
    
    private lazy var itemViews: [UIView] = dataList.map { data in
        switch data.type {
        case .text:
            let view = AlarmMainTextView()
            view.text = data.value[0]
            return view
        case .view:
            let view = AlarmMainItemView(alarmType: .thunder, isActive: true)
            view.alarmType = data.alarmType ?? .thunder
            view.title = data.value[0]
            view.alarmDescription = data.value[1]
            view.time = data.value[2]
            view.isActive = data.isActive
            view.isUserInteractionEnabled = true
            let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpView(gesture:)))
            view.addGestureRecognizer(gesture)
            return view
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .white
        setStatusBar(.white)
        navigationBar.layer.applyShadow()
    }
    
    private func setLayout() {
        view.addSubviews([contentScrollView, navigationBar])
        contentScrollView.addSubview(contentView)
        contentView.addSubviews([headerView, contentStackView])
        
        for view in itemViews {
            contentStackView.addArrangedSubview(view)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        contentScrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - @objc
    
    @objc func touchUpView(gesture: CustomGesture) {
        let dvc = AlarmPopUpViewController()
        dvc.modalTransitionStyle = .crossDissolve
        dvc.modalPresentationStyle = .overFullScreen
        present(dvc, animated: true)
    }
}

class CustomGesture: UITapGestureRecognizer {
    var alarmType: AlarmType = .lightning
}
