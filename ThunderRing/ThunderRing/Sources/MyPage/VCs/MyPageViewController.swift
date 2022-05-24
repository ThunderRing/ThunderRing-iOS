//
//  MyPageViewController.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

import SnapKit
import Then

import Firebase

final class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var navigationBar: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userInfoView: UIView!
    
    @IBOutlet weak var myPageTableView: UITableView!
    
    private var friendCount = 0
    private var groupCount = 0
    private var lightningCount = 0
    let userID = FirebaseDataService.instance.currentUserUid
    
    @IBOutlet weak var friendCountLabel: UILabel!
    @IBOutlet weak var groupCountLabel: UILabel!
    @IBOutlet weak var lightningCountLabel: UILabel!
    
    private let imagePicker = UIImagePickerController()
    
    private lazy var groupTendencyView = GroupTendencyView(tagType: .diligent).then {
        $0.tagType = .diligent
        $0.makeRounded(cornerRadius: 3)
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
        setTendencyView()
        setTableView()
        setImagePicker()
        setGesture()
        updateUserInfo()
    }
    
    // MARK: - Init UI
    
    private func configTabBarUI() {
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configUI() {
        setNavigationBar(customNavigationBarView: navigationBar, title: "마이페이지", backBtnIsHidden: true, closeBtnIsHidden: true, bgColor: .background)
        setStatusBar(.background)
        
        userImageView.makeRounded(cornerRadius: 30)
        userInfoView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 6, bounds: true)
    }
    
    // MARK: - Custom Method
    
    private func setTendencyView() {
        view.addSubview(groupTendencyView)
        
        groupTendencyView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(238)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(95)
            $0.height.equalTo(21)
        }
    }
    
    private func setTableView() {
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
        
        myPageTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myPageTableView.separatorColor = .gray300
        myPageTableView.backgroundColor = .background
        myPageTableView.allowsMultipleSelection = true
        myPageTableView.isScrollEnabled = false
        
        myPageTableView.register(MyPageAlarmTableViewCell.self, forCellReuseIdentifier: MyPageAlarmTableViewCell.identifier)
        myPageTableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        myPageTableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.identifier)
        myPageTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        myPageTableView.register(LogOutTableViewCell.self, forCellReuseIdentifier: LogOutTableViewCell.identifier)
    }
    
    private func setImagePicker() {
        imagePicker.delegate = self
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    private func setGesture() {
        userImageView.isUserInteractionEnabled = true
        
        [friendCountLabel, groupCountLabel, lightningCountLabel].forEach {
            $0?.isUserInteractionEnabled = true
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        userImageView.addGestureRecognizer(tapGesture)
        
        let friendCountTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpFriendCount))
        friendCountLabel.addGestureRecognizer(friendCountTapGesture)
        
        let groupCountTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpGroupCount))
        groupCountLabel.addGestureRecognizer(groupCountTapGesture)
        
        let lightningCountTapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpLightningCount))
        lightningCountLabel.addGestureRecognizer(lightningCountTapGesture)
    }
    
    private func updateUserInfo(){
        FirebaseDataService.instance.userRef.child(userID!).child("user").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let userName = value?["name"] as? String ?? "error"
            let imageName = value?["imageName"] as? String ?? ""
            
            self.userNameLabel.text = userName
            self.userImageView.image = UIImage(named: imageName)
        })
        
    }
    
    // MARK: - @objc
    
    @objc func pickImage() {
        present(self.imagePicker, animated: true)
    }
    
    @objc func touchUpFriendCount() {
        let dvc = MyPageFriendCountViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    @objc func touchUpGroupCount() {
        let dvc = MyPageGroupCountViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    @objc func touchUpLightningCount() {
        let dvc = MyPageLightningCountViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - UITableView Delegate

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let dvc = AccountInfoViewController()
            navigationController?.pushViewController(dvc, animated: true)
        } else if indexPath.section == 4 {
            
            do {
                try Auth.auth().signOut()
                
            } catch let signOutError as NSError{
                print("Error signOut: %@", signOutError)
            }
            guard let vc = UIStoryboard(name: Const.Storyboard.Name.SignIn, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.SignIn) as? SignInViewController else { return }
            let dvc = UINavigationController(rootViewController: vc)
            dvc.modalTransitionStyle = .crossDissolve
            dvc.modalPresentationStyle = .fullScreen
            present(dvc, animated: true, completion: nil)
            
        }
    }
}

// MARK: - UITableView DataSource

extension MyPageViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageAlarmTableViewCell.identifier) as? MyPageAlarmTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.contentView.isUserInteractionEnabled = false
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.identifier) as? AccountTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier) as? QuestionTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier) as? InfoTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LogOutTableViewCell.identifier) as? LogOutTableViewCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UIImagePickerController Delegate
 
extension MyPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        
        userImageView.image = newImage
        picker.dismiss(animated: true, completion: nil) 
    }
}
