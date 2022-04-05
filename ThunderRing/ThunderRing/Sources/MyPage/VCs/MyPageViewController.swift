//
//  MyPageViewController.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

final class MyPageViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var navigationBar: UIView!
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userInfoView: UIView!
    
    @IBOutlet weak var myPageTableView: UITableView!
    
    private var friendCount = 0
    private var groupCount = 0
    private var thunderCount = 0
    
    private let imagePicker = UIImagePickerController()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bind()
    }
    
    private func configUI() {
        setNavigationBar(customNavigationBarView: navigationBar, title: "마이페이지", backBtnIsHidden: true, closeBtnIsHidden: true, bgColor: .background)
        setStatusBar(.background)
        userImageView.makeRounded(cornerRadius: 30)
        userInfoView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 6, bounds: true)
        
        myPageTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myPageTableView.separatorColor = .gray300
        myPageTableView.backgroundColor = .background
        myPageTableView.allowsMultipleSelection = true
        myPageTableView.isScrollEnabled = false
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
    }
    
    private func bind() {
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
        
        myPageTableView.register(MyPageAlarmTableViewCell.self, forCellReuseIdentifier: MyPageAlarmTableViewCell.identifier)
        myPageTableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        myPageTableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.identifier)
        myPageTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        myPageTableView.register(LogOutTableViewCell.self, forCellReuseIdentifier: LogOutTableViewCell.identifier)
        
        imagePicker.delegate = self
        
        userImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        userImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - @objc
    
    @objc func pickImage() {
        self.present(self.imagePicker, animated: true)
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
