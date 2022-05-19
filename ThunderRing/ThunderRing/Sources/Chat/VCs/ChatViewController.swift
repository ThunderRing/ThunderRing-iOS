//
//  ChatVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

import SnapKit
import Then
import Firebase

final class ChatViewController: UIViewController {
    
    // MARK: - Properties
    
    public var destinationUID: String?
    public var chatRoomKey: String?
    public var chatCount: Int?
    var comments : [MessageData] = []
    var userInfo: [UserInfoModel] = []
    var uid = FirebaseDataService.instance.currentUserUid
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var userCountLabel: UILabel!
    
    @IBOutlet weak var hamburgerButton: UIButton!
    
    private var guideView = GuideView().then {
        $0.makeRounded(cornerRadius: 7)
    }
    
    private var chatCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.backgroundColor = .systemBackground
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    private var backgroundView = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = .gray300
    }
    
    private var textField = UITextField().then {
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 20, bounds: true)
        $0.backgroundColor = UIColor(red: 242.0/255.0, green: 241.0/255.0, blue: 246.0/255.0, alpha: 1.0)
        $0.placeholder = "메시지 입력하기"
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
        $0.setLeftPaddingPoints(15)
    }
    
    private lazy var sendButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnSend"), for: .normal)
    }
    
    // MARK: - Properties
    
    var chatTitle: String?
    
    private let nowDate = Date()
    var memberNum = 3
    
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "MM월 dd일 (E) HH:mm:ss"
        $0.locale = Locale(identifier:"ko")
    }
    
    private let timeFormatter = DateFormatter().then {
        $0.dateFormat = "a hh:mm"
        $0.locale = Locale(identifier:"ko")
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDestinationUserInfo()
        
        configUI()
        setLayout()
        setCollectionView()
        getNotification()
        setAction()
    }
    
    private func configUI() {
        view.backgroundColor = .background
        
        customNavigationBarView.backgroundColor = .white
        setStatusBar(.white)
        
        titleLabel.text = "\(chatTitle!)"
        titleLabel.font = .SpoqaHanSansNeo(type: .medium, size: 16)
        titleLabel.setTextSpacingBy(value: -0.6)
        
        userCountLabel.text = "\(memberNum)"
        
        customNavigationBarView.backgroundColor = .white
        customNavigationBarView.layer.applyShadow()
        
        guideView.title = "내일 오후 9:41 펑"
        //        guideView.title = "펑 시각 " + dateFormatter.string(from: nowDate.addingTimeInterval(+(60 * 60 * 24)))
        
        chatCollectionView.backgroundColor = .background
        
        textField.delegate = self
        textField.font = .SpoqaHanSansNeo(type: .regular, size: 15)
        textField.setRightIcon(5, 24, UIImage(named: "icnHappy")!)
    }
    
    private func setLayout() {
        customNavigationBarView.addSubview(guideView)
        view.addSubviews([chatCollectionView, backgroundView])
        backgroundView.addSubviews([lineView, textField, sendButton])
        
        guideView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(51)
            $0.width.equalTo(106)
            $0.height.equalTo(23)
            $0.centerX.equalToSuperview()
        }
        
        chatCollectionView.snp.makeConstraints {
            $0.top.equalTo(customNavigationBarView.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(self.view)
            $0.bottom.equalToSuperview().inset(80)
        }
        
        backgroundView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(59)
        }
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(276)
            $0.height.equalTo(40)
        }
        
        sendButton.snp.makeConstraints {
            $0.leading.equalTo(textField.snp.trailing).offset(10)
            $0.centerY.equalTo(textField.snp.centerY)
        }
        
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(
                equalTo: backgroundView.bottomAnchor,
                constant: 0
            )
        ])
    }
    
    private func setCollectionView() {
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        
        chatCollectionView.register(CounterpartChatCVC.self, forCellWithReuseIdentifier: "CounterpartChatCVC")
        chatCollectionView.register(MyChatCVC.self, forCellWithReuseIdentifier: "MyChatCVC")
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(sendMessage(_:)), name: NSNotification.Name("SendMessage"), object: nil)
    }
    
    private func setAction() {
        backButton.addAction(UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
        
        sendButton.addAction(UIAction(handler: { _ in
            NotificationCenter.default.post(name: NSNotification.Name("SendMessage"), object: self.textField.text ?? "")
            self.view.endEditing(true)
        }), for: .touchUpInside)
        
        hamburgerButton.addAction(UIAction(handler: { _ in
            // FIXME: - 화면 연결
        }), for: .touchUpInside)
    }
    
    private func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    // MARK: - @objc
    
    @objc func sendMessage(_ notification: Notification) {
        
        if textField.text?.isEmpty == false {
            uploadChat()
        }
        
        textField.text?.removeAll()
    }
    
    func uploadChat() {
        
        let value : Dictionary<String,Any> = [
            
            "uid" : uid!,
            "message" : textField.text!,
            "timeStamp" : ServerValue.timestamp()
        ]
        
        let updateNewMessage : Dictionary<String, Any> = [
            
            "contentLabel" : textField.text!,
            "chatCount" : 0,
            "timeStamp" : ServerValue.timestamp(),
        ]
        
        let updateCounterPartMessage : Dictionary<String, Any> = [
            
            "contentLabel" : textField.text!,
            "chatCount": chatCount! + 1,
            "timeStamp" : ServerValue.timestamp(),
        ]
        
        Database.database().reference().child("chatrooms").child(chatRoomKey!).child("comments").childByAutoId().setValue(value)
        FirebaseDataService.instance.userRef.child(uid!).child("chatRoomList").child(chatRoomKey!).updateChildValues(updateNewMessage)
        FirebaseDataService.instance.userRef.child(destinationUID!).child("chatRoomList").child(chatRoomKey!).updateChildValues(updateCounterPartMessage)
        
    } //successful
    
    func getDestinationUserInfo(){
        
        FirebaseDataService.instance.userRef.child(destinationUID!).child("user").observeSingleEvent(of: .value, with: {(snapshot) in
            self.userInfo.removeAll()
            if let data = snapshot.value as? Dictionary<String, AnyObject> {
                let username = data["name"] as! String
                let profileImageName = data["imageName"] as! String
                let uid = data["uid"] as! String
                let userInfo = UserInfoModel(uid: uid, userName: username, profileImageName: profileImageName)
                self.userInfo.append(userInfo)
                
                self.getMessageList()
                self.getDestinationUserChatCount()
            }
            
        })
        
    }
    
    func getDestinationUserChatCount(){
        FirebaseDataService.instance.userRef.child(destinationUID!).child("chatRoomList").child(chatRoomKey!).observe(.value, with: {(snapshot) in
            if let data = snapshot.value as? Dictionary<String,AnyObject> {
                self.chatCount = data["chatCount"] as? Int
            }
        })
    }
    
    func getMessageList() {
        
        FirebaseDataService.instance.chatroomsRef.child(chatRoomKey!).child("comments").observe(DataEventType.value, with: {
            (datasnapshot) in
            self.comments.removeAll()
            if let data = datasnapshot.value as? Dictionary<String, AnyObject> {
                for (_, data) in data {
                    
                    if let chatData = data as? Dictionary<String, AnyObject> {
                        let uid = chatData["uid"] as! String
                        let comment = chatData["message"] as! String
                        let timeStamp = chatData["timeStamp"] as! Int
                        let chatDataModel = MessageData(uid: uid, comment: comment, timeStamp: timeStamp)
                        self.comments.append(chatDataModel)
                        
                        DispatchQueue.main.async(execute: {
                            self.chatCollectionView.reloadData()
                        })
                    }
                    
                }
            }
            
        })
    } //success
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        comments.sort(by: {$0.timeStamp! < $1.timeStamp!})
        if comments[indexPath.row].uid == destinationUID { //counterPart
            let height = heightForView(text: comments[indexPath.row].messageText!, font: .systemFont(ofSize: 14), width: 220)
            
            return CGSize(width: self.view.frame.width, height: height + 43)
            //            if height < 40 {
            //                return CGSize(width: self.view.frame.width, height: height + 40)
            //            }
            //            else if height >= 40 && height < 100 {
            //                return CGSize(width: self.view.frame.width, height: height + 40)
            //            }
            //            else {
            //                return CGSize(width: self.view.frame.width, height: height + 100)
            //            }
        } else if comments[indexPath.row].uid == uid { //me
            let height = heightForView(text: comments[indexPath.row].messageText!, font: .systemFont(ofSize: 14), width: 220)
            
            return CGSize(width: self.view.frame.width, height: height + 23)
            //            if height < 50 {
            //                return CGSize(width: self.view.frame.width, height: height + 40)
            //            }
            //            else if height >= 50 && height < 100 {
            //                return CGSize(width: self.view.frame.width, height: height + 40)
            //            }
            //            else {
            //                return CGSize(width: self.view.frame.width, height: height + 100)
            //            }
        } else {
            return CGSize(width: self.view.frame.width, height: 38)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
    
}

extension ChatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        comments.sort(by: {$0.timeStamp! < $1.timeStamp!})
        if comments[indexPath.row].uid != uid {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CounterpartChatCVC.identifier, for: indexPath)
            if let counterpartChatCell = cell as? CounterpartChatCVC {
                counterpartChatCell.initUI(model: comments[indexPath.row], userModel: userInfo[0])
                counterpartChatCell.couterpartTextLabel.adjustsFontSizeToFitWidth = true
            }
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyChatCVC.identifier, for: indexPath)
            if let myChatCell = cell as? MyChatCVC {
                myChatCell.initUI(model: comments[indexPath.row])
            }
            return cell
        }
    }
}

// MARK: - UITextField Delegate

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Guide View

fileprivate final class GuideView: UIView {
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 12)
        $0.setTextSpacingBy(value: -4)
    }
    
    var title: String = "" {
        didSet {
            titleLabel.text = "\(title)"
        }
    }
    
    init() {
        super.init(frame: .zero)
        setTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTitle() {
        backgroundColor = .purple100.withAlphaComponent(0.1)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}

extension Int {
    
    var toDayTime: String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "a hh:mm"
        
        let date = Date(timeIntervalSince1970: Double(self)/1000)
        
        return dateFormatter.string(from: date)
    }
}
