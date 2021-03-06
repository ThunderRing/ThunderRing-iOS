//
//  RecruitingViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/09.
//

import UIKit

import SnapKit
import Then

final class HomeRecruitingViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "모집 중인 번개", backButtonIsHidden: false, closeButtonIsHidden: true)
    
    private var recruitingTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.register(HomeRecruitingTableViewCell.self, forCellReuseIdentifier: HomeRecruitingTableViewCell.cellIdentifier)
        $0.estimatedRowHeight = 204
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configNavigationUI()
        configTabBarUI()
        getNotification()
    }
    
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
    
    // MARK: - InitUI

    private func configTabBarUI() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func configUI() {
        view.backgroundColor = .background
        
        setStatusBar(.white)
        navigationBar.layer.applyShadow()
        
        recruitingTableView.backgroundColor = .background
    }
    
    private func setLayout() {
        view.addSubviews([recruitingTableView, navigationBar])
        
        navigationBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        recruitingTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        recruitingTableView.delegate = self
        recruitingTableView.dataSource = self
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(touchUpPlusButton(_:)), name: NSNotification.Name("TouchUpPlusButton"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(touchUpJoinButton(_:)), name: NSNotification.Name("JoinTheGroup"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func touchUpPlusButton(_ notification: Notification) {
        let dvc = AlarmPopUpViewController()
        dvc.modalTransitionStyle = .crossDissolve
        dvc.modalPresentationStyle = .overFullScreen
        dvc.handleTap(alarmType: .lightning)
        dvc.lightningName = "젤리 먹자"
        dvc.groupName = "[젤리팟]"
        dvc.member = "마예지"
        dvc.memberCount = 5
        dvc.date = "5월 25일 수요일 오후 8:00"
        dvc.location = "연남동"
        present(dvc, animated: true)
    }
    
    @objc func touchUpJoinButton(_ notification: Notification) {
        lightningData[0].members?.removeLast()
        lightningData[0].members?.append("proJiwon")
        recruitingTableView.reloadData()
    }
}

extension HomeRecruitingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
}

extension HomeRecruitingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lightningData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeRecruitingTableViewCell.cellIdentifier) as? HomeRecruitingTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.initCell(lightning: lightningData[indexPath.row])
        return cell
    }
}
