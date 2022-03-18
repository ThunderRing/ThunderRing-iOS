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
    private lazy var chatMainTopView = ChatMainTopView()
    
    private lazy var chatListTableView = UITableView().then {
        $0.register(ChatMainTableViewCell.self, forCellReuseIdentifier: ChatMainTableViewCell.CellIdentifier)
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
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background
        
        view.addSubviews([navigationBar, chatMainTopView, chatListTableView])
        
        navigationBar.layer.applyShadow()
    }
    
    private func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        chatMainTopView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.height.equalTo(90)
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
    }
}

// MARK: - UITableView Delegate

extension ChatMainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - 채팅 화면으로 이동
    }
}

// MARK: - UITableView DataSource

extension ChatMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: - 정적으로 카운트
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMainTableViewCell.CellIdentifier) as? ChatMainTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        return cell
    }
}
