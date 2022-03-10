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
    
    private lazy var navigationBar = TDSNavigationBar(self, view: .main, backButtonIsHidden: false, closeButtonIsHidden: true)
    
    private var cruitingTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.register(HomeRecruitingTableViewCell.self, forCellReuseIdentifier: HomeRecruitingTableViewCell.CellIdentifier)
        $0.estimatedRowHeight = 204
        $0.rowHeight = UITableView.automaticDimension
        $0.separatorStyle = .none
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background
        
        navigationBar.setTitle(title: "모집 중인 번개")
        
        view.addSubviews([navigationBar, cruitingTableView])
    }
    
    private func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        cruitingTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        cruitingTableView.delegate = self
        cruitingTableView.dataSource = self
        
        lightningData = [
            LightningDataModel(groupName: "[독서모임]",
                               lightningName: "Post Poetics 방문해요",
                               description: "",
                               date: "10 / 26",
                               time: "오전 11:00",
                               location: "이태원역",
                               minNumber: 3,
                               maxNumber: 7,
                               members: ["imgCoin"]),
            LightningDataModel(groupName: "[디미모여]",
                               lightningName: "스벅 카공 할 사람",
                               description: "",
                               date: "10 / 26",
                               time: "오후 8:00",
                               location: "태릉입구역",
                               minNumber: 2,
                               maxNumber: 9,
                               members: ["imgCoin", "imgDog1"])
        ]
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeRecruitingTableViewCell.CellIdentifier) as? HomeRecruitingTableViewCell else { return UITableViewCell() }
        cell.initCell(lightning: lightningData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - Custom Delegate

extension HomeRecruitingViewController: HomeRecruitingTableViewCellViewDelegate {
    func touchUpPlusButton() {
        print("👏🏻 Tapped!!")
    }
}
