//
//  ChatListViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/19.
//

import UIKit

import SnapKit
import Then

import Firebase

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
        $0.setTextSpacingBy(value: -0.6)
    }
    
    private lazy var chatListTableView = UITableView().then {
        $0.register(ChatMainTableViewCell.self, forCellReuseIdentifier: ChatMainTableViewCell.CellIdentifier)
        $0.backgroundColor = .background
    }
    
    private var chatLists = [ChatListDataModel]()
    var uid = FirebaseDataService.instance.currentUserUid
    var destinationUID: String?

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
        fetchChatoomsList()
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
    }
    
    private func fetchChatoomsList(){
        
        FirebaseDataService.instance.userRef.child(self.uid!).child("chatRoomList").observe(.value, with: {(snapshot) in
            self.chatLists.removeAll()
            if let data = snapshot.value as? Dictionary<String, AnyObject> {
                for (key, data) in data {
                    
                    if let chatListData = data as? Dictionary<String, AnyObject> {
                        let destinationUID = chatListData["destinationUID"] as! String
                        let groupName = chatListData["groupName"] as! String
                        let imageName = chatListData["imageName"] as! String
                        let thunderName = chatListData["thunderName"] as! String
                        let countUsers = chatListData["userCount"] as! Int
                        let contentLabel = chatListData["contentLabel"] as! String
                        let timeStamp = chatListData["timeStamp"] as! Int
                        let chatCount = chatListData["chatCount"] as! Int
                        let chatList = ChatListDataModel(key: key, destinationUID: destinationUID, imageName: imageName, groupName: groupName, thunderName: thunderName, countUsers: countUsers, contentLabel: contentLabel, timeStamp: timeStamp, chatCount: chatCount)
                        self.chatLists.append(chatList)
                        
                        DispatchQueue.main.async(execute: {
                            self.chatListTableView.reloadData()
                        })
                    }
                    
                }
            }
            
        })
        
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
        dvc.chatTitle = chatLists[indexPath.row].thunderName
        dvc.memberNum = chatLists[indexPath.row].countUsers!
        dvc.chatRoomKey = chatLists[indexPath.row].key
        dvc.destinationUID = chatLists[indexPath.row].destinationUID
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - UITableView DataSource

extension ChatMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: - 데이터 사용해서 동적으로 반환
        return chatLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatMainTableViewCell.CellIdentifier) as? ChatMainTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        chatLists.sort(by: {$0.timeStamp! >  $1.timeStamp!})
        cell.initCell(chatList: chatLists[indexPath.row])
        return cell
    }
}
