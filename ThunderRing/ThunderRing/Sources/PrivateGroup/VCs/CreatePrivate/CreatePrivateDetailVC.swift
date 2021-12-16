//
//  CreatePrivateDetailVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/02.
//

import UIKit

class CreatePrivateDetailVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionCountLabel: UILabel!
    
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var addMemberButton: UIButton!
    @IBOutlet weak var memberCollectionView: UICollectionView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    // MARK: - Properties
    
    var groupName = "그룹명"
    var groupImage = UIImage()
    var members = [String]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: false, closeBtnIsHidden: false, bgColor: .background)
        setStatusBar(.background)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setAction()
        setTextField()
        setCollectionView()
        getNotification()
    }
}

// MARK: - Custom Methods

extension CreatePrivateDetailVC {
    private func initUI() {
        nextButton.isEnabled = false
        nextButton.setTitleColor(.gray100, for: .normal)
        nextButton.initViewBorder(borderWidth: 0, borderColor: UIColor.clear.cgColor, cornerRadius: 27, bounds: true)
        
        descriptionTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        descriptionTextField.setLeftPaddingPoints(15)
        
        addMemberButton.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
    }
    
    private func setAction() {
        nextButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "CompleteCreateVC") as? CompleteCreateVC else { return }
            dvc.groupImage = self.groupImage
            dvc.groupName = self.groupName
            dvc.groupDescrption = self.descriptionTextField.text!
            dvc.groupCounts = self.members.count + 1
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
        
        addMemberButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "AddMemberVC") else { return }
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
    }
    
    private func setTextField() {
        descriptionTextField.delegate = self
    }
    
    private func setCollectionView() {
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        
        memberCollectionView.register(MemberCVC.self, forCellWithReuseIdentifier: MemberCVC.identifier)
        
        memberCollectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UICollectionView Delegate

extension CreatePrivateDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 19 - 19) / 3
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension CreatePrivateDetailVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemberCVC.identifier, for: indexPath) as? MemberCVC else { return UICollectionViewCell() }
        cell.initCell(name: members[indexPath.row])
        return cell
    }
}


// MARK: - UITextField Delegate

extension CreatePrivateDetailVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
        
        descriptionCountLabel.textColor = .purple100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        
        if descriptionTextField.hasText {
            descriptionCountLabel.textColor = .black
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = .purple100
            nextButton.setTitleColor(.white, for: .normal)
        } else {
            descriptionCountLabel.textColor = .gray200
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = .gray200
            nextButton.setTitleColor(.gray100, for: .normal)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.descriptionCountLabel.text = String("\(textField.text!.count)/15")
    }
}

// MARK: - Notificaiton

extension CreatePrivateDetailVC {
    private func getNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showCollectionView),
                                               name: NSNotification.Name("AddMember"), object: nil)
    }
    
    @objc
    func showCollectionView(_ notification: Notification) {
        members = notification.object as! [String]
        memberCollectionView.reloadData()
        memberCollectionView.isHidden = false
    }
}
