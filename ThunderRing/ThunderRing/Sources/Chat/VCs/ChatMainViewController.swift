//
//  ChatListViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/19.
//

import UIKit

import SnapKit
import Then

final class ChatMainViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = TDSNavigationBar(self, view: .chat, backButtonIsHidden: true, closeButtonIsHidden: true)
    private lazy var chatMainTopView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.text = "24시간이 지난 후 채팅방은 펑 사라져요"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private lazy var chatListTableView = UITableView().then {
        $0.register(ChatMainTableViewCell.self, forCellReuseIdentifier: ChatMainTableViewCell.CellIdentifier)
        $0.backgroundColor = .background
    }
    
    private var chatLists = [ChatListDataModel]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
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
        setStatusBar(.white)
        
        chatMainTopView.layer.applyShadow()
    }
    
    private func setLayout() {
        view.addSubviews([chatListTableView, chatMainTopView])
        chatMainTopView.addSubview(navigationBar)
        chatMainTopView.addSubview(subTitleLabel)
        
        chatMainTopView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(140)
        }
        
        navigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(47)
            $0.height.equalTo(50)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.equalToSuperview().inset(25)
        }
        
        chatListTableView.snp.makeConstraints {
            $0.top.equalTo(chatMainTopView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.separatorStyle = .none
        
        chatLists.append(contentsOf: [
            ChatListDataModel(groupImage: "imgDog1", hashTag: "양파링 걸즈", title: "혜화역 혼가츠 먹자", subTitle: "안녕하세요!", count: 3, time: 1)
        ])
    }
}

// MARK: - UITableView Delegate

extension ChatMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Chat, bundle: nil)
        guard let dvc = chatStoryboard.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController else { return }
        dvc.chatTitle = chatLists[indexPath.row].title
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - UITableView DataSource

extension ChatMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: - 데이터 사용해서 동적으로 반환 
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMainTableViewCell.CellIdentifier) as? ChatMainTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
}
