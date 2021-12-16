//
//  MyPageVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

class MyPageVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var profileBackView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userInfoView: UIView!
    
    @IBOutlet weak var myPageTableView: UITableView!
    
    // MARK: - Properties
    
    private var friendCount = 0
    private var groupCount = 0
    private var thunderCount = 0
    
    let imagePicker = UIImagePickerController()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "마이페이지", backBtnIsHidden: true, closeBtnIsHidden: true, bgColor: .white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setTableView()
        setImagePicker()
    }
}

// MARK: - Custom Methods

extension MyPageVC {
    func initUI() {
        customNavigationBarView.layer.applyShadow()
        
        profileBackView.initViewBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: profileBackView.frame.width / 2, bounds: true)
        userInfoView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 5, bounds: true)
    }
    
    func setTableView() {
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
        
        myPageTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myPageTableView.separatorColor = .gray
        myPageTableView.backgroundColor = .background
        myPageTableView.allowsMultipleSelection = true
        myPageTableView.isScrollEnabled = false
        
        myPageTableView.register(MyPageAlarmTVC.self, forCellReuseIdentifier: MyPageAlarmTVC.identifier)
        myPageTableView.register(AccountTVC.self, forCellReuseIdentifier: AccountTVC.identifier)
        myPageTableView.register(QuestionTVC.self, forCellReuseIdentifier: QuestionTVC.identifier)
        myPageTableView.register(InfoTVC.self, forCellReuseIdentifier: InfoTVC.identifier)
        myPageTableView.register(LogOutTVC.self, forCellReuseIdentifier: LogOutTVC.identifier)
    }
    
    private func setImagePicker() {
        self.imagePicker.sourceType = .photoLibrary
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        
        userImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        userImageView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - @objc

extension MyPageVC {
    @objc
    func pickImage() {
        self.present(self.imagePicker, animated: true)
    }
}

// MARK: - UITableView Delegate

extension MyPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

// MARK: - UITableView DataSource

extension MyPageVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageAlarmTVC.identifier) as? MyPageAlarmTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTVC.identifier) as? AccountTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTVC.identifier) as? QuestionTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTVC.identifier) as? InfoTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LogOutTVC.identifier) as? LogOutTVC else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UIImagePickerController Delegate
 
extension MyPageVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        
        self.userImageView.image = newImage
        picker.dismiss(animated: true, completion: nil) 
        
    }
}
