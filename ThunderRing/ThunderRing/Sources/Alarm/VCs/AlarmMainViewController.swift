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
        Data(type: DataType.text, value: ["진행중인 알림"], isActive: false),
        Data(type: DataType.view, value: ["[젤리팟]", "젤리먹자", "번개가 도착했어요. 내용을 확인해보세요", "1분 전"], alarmType: .lightning, isActive: true),
        Data(type: DataType.view, value: ["[아이스케키]", "민초 먹으러 갈래","천둥이 울렸어요. 채팅을 볼까요?", "2시간 전"], alarmType: .thunder, isActive: true),
        Data(type: DataType.view, value: ["[Oil PASTEL]", "공덕역 카페로","번개가 취소되었어요", "2시간 전"], alarmType: .cancel, isActive: true),
        Data(type: DataType.text, value: ["5월 24일"], isActive: false),
        Data(type: DataType.view, value: ["[양파링걸즈]", "한강 치맥하자","번개가 취소되었어요", "1일 전"], alarmType: .cancel, isActive: false),
        Data(type: DataType.text, value: ["5월 22일"], isActive: false),
        Data(type: DataType.view, value: ["[도예공방]", "오늘은 컵 만들어요","천둥이 울렸어요. 채팅을 볼까요?", "2일 전"], alarmType: .cancel, isActive: false),
        Data(type: DataType.view, value: ["[러너]", "달려보아요", "천둥이 울렸어요. 채팅을 볼까요?", "3일 전"], alarmType: .thunder, isActive: false)
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
            view.subTitle = data.value[1]
            view.alarmDescription = data.value[2]
            view.time = data.value[3]
            view.isActive = data.isActive
            view.isUserInteractionEnabled = data.isActive
            
            if view.alarmType == .cancel {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpCancelView))
                view.addGestureRecognizer(gesture)
            } else if view.alarmType == .thunder {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpThunderView))
                view.addGestureRecognizer(gesture)
            } else {
                let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpLightningView))
                view.addGestureRecognizer(gesture)
            }
            
            return view
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationUI()
        configTabBarUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        getNotification()
    }
    
    // MARK: - Init UI
    
    private func configTabBarUI() {
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configUI() {
        view.backgroundColor = .background
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
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(33)
        }
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(getJoinNotification), name: NSNotification.Name("Join"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func touchUpCancelView() {
        let dvc = AlarmPopUpViewController()
        dvc.modalTransitionStyle = .crossDissolve
        dvc.modalPresentationStyle = .overFullScreen
        dvc.handleTap(alarmType: .cancel)
        present(dvc, animated: true)
    }
    
    @objc func touchUpThunderView() {
        self.tabBarController?.selectedIndex = 1
    }
    
    @objc func touchUpLightningView() {
        let vc = AlarmPopUpViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        
        vc.lightningName = dataList[1].value[1]
        vc.groupName = dataList[1].value[0]
        vc.member = "마예지"
        vc.memberCount = 5
        vc.date = "5월 25일 수요일 오후 2:00"
        vc.location = "연남동"
        
        vc.handleTap(alarmType: .lightning)
        present(vc, animated: true)
    }
    
    @objc func getJoinNotification() {
        dataList = [
            Data(type: DataType.text, value: ["진행중인 알람"], isActive: false),
            Data(type: DataType.view, value: ["[젤리팟]", "젤리먹자","번개에 참여했어요", "1분 전"], alarmType: .lightning, isActive: true),
            Data(type: DataType.view, value: ["[아이스케키]", "민초 먹으러 갈래","천둥이 울렸어요. 채팅을 볼까요?", "2시간 전"], alarmType: .thunder, isActive: true),
            Data(type: DataType.view, value: ["[Oil PASTEL]", "공덕역 카페로","번개가 취소되었어요", "2시간 전"], alarmType: .cancel, isActive: true),
            Data(type: DataType.text, value: ["5월 24일"], isActive: false),
            Data(type: DataType.view, value: ["[양파링걸즈]", "한강 치맥하자","번개가 취소되었어요", "1일 전"], alarmType: .cancel, isActive: false),
            Data(type: DataType.text, value: ["5월 22일"], isActive: false),
            Data(type: DataType.view, value: ["[도예공방]", "오늘은 컵 만들어요","천둥이 울렸어요. 채팅을 볼까요?", "3일 전"], alarmType: .cancel, isActive: false),
            Data(type: DataType.view, value: ["[러너]", "달려보아요", "천둥이 울렸어요. 채팅을 볼까요?", "4일 전"], alarmType: .thunder, isActive: false)
        ]
        
        for view in itemViews {
            contentStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        itemViews = dataList.map { data in
            switch data.type {
            case .text:
                let view = AlarmMainTextView()
                view.text = data.value[0]
                return view
            case .view:
                let view = AlarmMainItemView(alarmType: .thunder, isActive: true)
                view.alarmType = data.alarmType ?? .thunder
                view.title = data.value[0]
                view.subTitle = data.value[1]
                view.alarmDescription = data.value[2]
                view.time = data.value[3]
                view.isActive = data.isActive
                view.isUserInteractionEnabled = data.isActive
                
                if view.alarmType == .cancel {
                    let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpCancelView))
                    view.addGestureRecognizer(gesture)
                } else if view.alarmType == .thunder {
                    let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpThunderView))
                    view.addGestureRecognizer(gesture)
                } else {
                    let gesture = UITapGestureRecognizer(target: self, action: #selector(touchUpLightningView))
                    view.addGestureRecognizer(gesture)
                }
                
                return view
            }
        }
        
        for view in itemViews {
            contentStackView.addArrangedSubview(view)
        }
    }
}
