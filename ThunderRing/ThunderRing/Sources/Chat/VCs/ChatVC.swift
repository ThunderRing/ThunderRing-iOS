//
//  ChatVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit
import SnapKit
import Then

class ChatVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var chatCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.backgroundColor = .systemBackground
        $0.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    // MARK: - Properties
    
    var chatTitle: String?
    
    private let nowDate = Date()
    private var memberNum = 1

    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "\(chatTitle!) \(memberNum)", backBtnIsHidden: false, closeBtnIsHidden: true, bgColor: .white)
        setStatusBar(.white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setLayout()
        setCollectionView()
    }
}

extension ChatVC {
    private func initUI() {
        view.backgroundColor = .background
        
        topView.backgroundColor = .white
        topView.layer.applyShadow()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일 h:mm (E)"
        dateFormatter.locale = Locale(identifier:"ko")
        
        descriptionLabel.text = "펑 시각 " + dateFormatter.string(from: nowDate)
        descriptionLabel.textColor = .purple100
        
        guard let text = self.descriptionLabel.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        let font = UIFont.SpoqaHanSansNeo(type: .medium, size: 14)
        attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "펑 시각"))
        attributeString.addAttribute(.foregroundColor, value: UIColor.gray100.cgColor, range: (text as NSString).range(of: "펑 시각"))

        self.descriptionLabel.attributedText = attributeString
        
        chatCollectionView.backgroundColor = .background
    }
    
    private func setLayout() {
        view.addSubviews([chatCollectionView])
        
        chatCollectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(self.view)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setCollectionView() {
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        
        chatCollectionView.register(CounterpartChatCVC.self, forCellWithReuseIdentifier: "CounterpartChatCVC")
        chatCollectionView.register(MyChatCVC.self, forCellWithReuseIdentifier: "MyChatCVC")
    }
}

extension ChatVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if chatData[indexPath.row].chatType == .counterpart {
            let height = heightForView(text: chatData[indexPath.row].messageText, font: .systemFont(ofSize: 14), width: 220)
            
            if height < 20 {
                return CGSize(width: self.view.frame.width, height: height + 60)
            }
            else if height >= 20 && height < 40 {
                return CGSize(width: self.view.frame.width, height: height + 80)
            }
            else {
                return CGSize(width: self.view.frame.width, height: height + 100)
            }
        } else if chatData[indexPath.row].chatType == .me {
            let height = heightForView(text: chatData[indexPath.row].messageText, font: .systemFont(ofSize: 14), width: 220)
            
            if height < 20 {
                return CGSize(width: self.view.frame.width, height: height + 28)
            }
            else if height >= 20 && height < 40 {
                return CGSize(width: self.view.frame.width, height: height + 80)
            }
            else {
                return CGSize(width: self.view.frame.width, height: height + 100)
            }
        } else {
            return CGSize(width: self.view.frame.width, height: self.view.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
    
}

extension ChatVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if chatData[indexPath.row].chatType == .counterpart {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CounterpartChatCVC.identifier, for: indexPath)
            if let counterpartChatCell = cell as? CounterpartChatCVC {
                counterpartChatCell.initUI(model: chatData[indexPath.row])
                counterpartChatCell.couterpartTextLabel.adjustsFontSizeToFitWidth = true
            }
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyChatCVC.identifier, for: indexPath)
            if let myChatCell = cell as? MyChatCVC {
                myChatCell.initUI(model: chatData[indexPath.row])
            }
            return cell
        }
    }
}

// MARK: - Label

extension ChatVC {
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    @objc func dismissChatView() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
