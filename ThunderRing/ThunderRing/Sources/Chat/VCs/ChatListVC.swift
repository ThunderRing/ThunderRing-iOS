//
//  ChatListVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit
import Firebase

class ChatListVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var chatListTableView: UITableView!
    
    // MARK: - Properties
    
    private var chatLists = [ChatListDataModel]()
    var uid = FirebaseDataService.instance.currentUserUid
    var keys: [String] = []
    var destinationUsers : [String] = []
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setTableView()
        setData()
    }
}

// MARK: - Custom Methods

extension ChatListVC {
    private func initUI() {
        topView.layer.applyShadow()
    }
    
    private func setTableView() {
        chatListTableView.delegate = self
        chatListTableView.dataSource = self
        
        chatListTableView.separatorStyle = .none
        chatListTableView.contentInset = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
        chatListTableView.backgroundColor = .background
        
        chatListTableView.register(ChatListTVC.self, forCellReuseIdentifier: ChatListTVC.identifier)
    }
    
    private func setData() {
        chatLists.append(contentsOf: [
            ChatListDataModel(groupImage: "imgDog1", hashTag: "양파링 걸즈", title: "혜화역 혼가츠 먹자", subTitle: "안녕하세요!", count: 3, time: 1)
            ])
    }
    
//    private func getChatoomsList(){
//        Database.database().reference().child("chatrooms").queryOrdered(byChild: "users/"+uid!).queryEqual(toValue: true).observeSingleEvent(of: DataEventType.value, with: {(datasnapshot) in
//
//            for item in datasnapshot.children.allObjects as? [DataSnapshot]{
//                self.chatLists.removeAll()
//                if let chatlistDic = item.value as? [String: AnyObject]{
//                    let chatListModel = ChatListDataModel(JSON: chatlistDic)
//                    self.keys.append(item.key)
//                    self.chatrooms.append(chatListModel)
//                }
//            }
//        })
//    }
}

// MARK: - UITableView Delegate

extension ChatListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as? ChatViewController else { return }
        dvc.chatTitle = chatLists[indexPath.row].title
        dvc.destinationRoomID = self.keys[indexPath.row]
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - UITableView DataSource

extension ChatListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatListTVC.identifier) as? ChatListTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.initCell(chatList: chatLists[indexPath.row])
        return cell
    }
}
