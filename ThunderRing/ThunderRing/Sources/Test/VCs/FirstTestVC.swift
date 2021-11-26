//
//  TestVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/19.
//

import UIKit

import SnapKit
import Then

class FirstTestVC: UIViewController {
    
    // MARK: - UI
    
    private let customNavigationBarView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private let progressLabel = UILabel().then {
        $0.text = "1/8"
        $0.textColor = .purple
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var progressView = UIProgressView().then {
        $0.progressTintColor = .purple100
        $0.progress = 0
    }
    
    private var testTableView = UITableView()
    
    // MARK: - Properties
    
    private var testAnswers = [TestDataModel]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "테스트 질문", backBtnIsHidden: true, closeBtnIsHidden: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        setLayout()
        setData()
        setTableView()
    }
}

extension FirstTestVC {
    private func initUI() {
        view.backgroundColor = .grayBackground
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.updateProgressViewWithAnimation()
        }
    }
    
    private func setLayout() {
        view.addSubviews([customNavigationBarView, progressLabel, progressView, testTableView])
        
        customNavigationBarView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(57)
        }
        
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(customNavigationBarView.snp.bottom).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(progressLabel.snp.bottom).offset(17)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(4)
        }
        
        testTableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(progressView.snp.bottom)
        }
    }
    
    func updateProgressViewWithAnimation() {
        UIView.animate(withDuration: 0.5) {
            if self.progressView.progress != 0.125 {
                self.progressView.setProgress(0.125, animated: true)
            }
        }
    }

    func setData() {
        testAnswers.append(contentsOf: [
            TestDataModel(answer: "같은 시험을 준비하는 (초면인) 사람들을\n모아 스터디룸에서 공부"),
            TestDataModel(answer: "친한 친구들과 함께 의지를 투합"),
            TestDataModel(answer: "혼자 카페에 가서 공부하는 사람들을 보며\n자극을 받아 열심히 공부"),
            TestDataModel(answer: "혼자 집에서 아무에게도 방해를 받지 않고\n집중하며 공부")
        ])
    }
    
    func setTableView() {
        testTableView.delegate = self
        testTableView.dataSource = self
        
        testTableView.separatorStyle = .none
        
        testTableView.register(TestTVC.self, forCellReuseIdentifier: TestTVC.identifier)
    }
}

// MARK: - TableView Delegate

extension FirstTestVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 119
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .black
        header.textLabel?.font = .SpoqaHanSansNeo(type: .bold, size: 22)
        header.textLabel?.textAlignment = .left
        header.textLabel?.numberOfLines = 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "시험을 앞둔 당신 공부를 해야 한다면?"
    }
}

// MARK: - TableView DataSource

extension FirstTestVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testAnswers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TestTVC.identifier) as? TestTVC else { return UITableViewCell() }
        cell.initCell(title: testAnswers[indexPath.row].answer)
        cell.selectionStyle = .none
        return cell
    }
}
