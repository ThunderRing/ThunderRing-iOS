//
//  CreatePrivateDetailVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/02.
//

import UIKit

import SnapKit
import Then

final class CreatePrivateDetailViewController: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var descriptionCountLabel: UILabel!
    
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var addMemberButton: UIButton!
    @IBOutlet weak var memberCollectionView: UICollectionView!
    
    private lazy var nextButton = TDSButton().then {
        $0.setTitle("다음", for: .normal)
        $0.isActivated = false
        $0.addTarget(self, action: #selector(touchUpNextButton), for: .touchUpInside)
    }
    
    // MARK: - Properties
    
    var groupName = "그룹명"
    var groupImage = UIImage()
    var members = [String]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "", backBtnIsHidden: false, closeBtnIsHidden: false, bgColor: .background)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bind()
        getNotification()
    }
    
    // MARK: - Init UI
    
    private func initUI() {
        descriptionTextField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        descriptionTextField.setLeftPaddingPoints(14)
        
        addMemberButton.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 10, bounds: true)
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(52)
        }
        NSLayoutConstraint.activate([
            view.keyboardLayoutGuide.topAnchor.constraint(
                equalTo: nextButton.bottomAnchor,
                constant: 10
            )
        ])
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        descriptionTextField.delegate = self
        
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        
        memberCollectionView.register(MemberCVC.self, forCellWithReuseIdentifier: MemberCVC.identifier)
        
        memberCollectionView.showsVerticalScrollIndicator = false
        
        addMemberButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "AddMemberVC") else { return }
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showCollectionView),
                                               name: NSNotification.Name("AddMember"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func touchUpNextButton() {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "CompleteCreateVC") as? CompleteCreatePrivateViewController else { return }
        dvc.groupImage = self.groupImage
        dvc.groupName = self.groupName
        dvc.groupDescrption = self.descriptionTextField.text!
        dvc.groupCounts = self.members.count + 1
        self.navigationController?.pushViewController(dvc, animated: true)
    }

    @objc func showCollectionView(_ notification: Notification) {
        if let members = notification.object {
            self.members = members as! [String]
        }
        memberCollectionView.reloadData()
        memberCollectionView.isHidden = false
    }
    
}

// MARK: - UICollectionView Delegate

extension CreatePrivateDetailViewController: UICollectionViewDelegateFlowLayout {
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

extension CreatePrivateDetailViewController: UICollectionViewDataSource {
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

extension CreatePrivateDetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 12, bounds: true)
        
        descriptionCountLabel.textColor = .purple100
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.initTextFieldBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 12, bounds: true)
        
        if descriptionTextField.hasText {
            descriptionCountLabel.textColor = .black
            
            nextButton.isActivated = true
        } else {
            descriptionCountLabel.textColor = .gray200
            
            nextButton.isActivated = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.descriptionCountLabel.text = String("\(textField.text!.count)/15")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.count)! + string.count - range.length
        return !(newLength > 15)
    }
}
