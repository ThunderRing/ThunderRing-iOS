//
//  AddMemberVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/02.
//

import UIKit
import Contacts

final class AddMemberViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var memberTableView: UITableView!
    
    let app = UIApplication.shared.delegate as! AppDelegate
    
    private let contactStroe = CNContactStore()
    private var contactList = [ContactData]()
    var selectedMembers = [String]()
    private var count = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactStroe.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("주소록 접근 가능")
            }
        }
        DispatchQueue.main.async {
            self.getContactData()
        }
        configUI()
        setTableView()
        setTextField()
        setAction()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        getContacts()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        confirmButton.titleLabel?.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        cancelButton.titleLabel?.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        
        countLabel.text = "\(count)"
    }
    
    // MARK: - Custom Method
    
    private func setTableView() {
        memberTableView.delegate = self
        memberTableView.dataSource = self
        
        memberTableView.contentInsetAdjustmentBehavior = .never
        memberTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        
        memberTableView.backgroundColor = .background
        memberTableView.layer.borderColor = UIColor.lightGray.cgColor
        memberTableView.showsVerticalScrollIndicator = false
        memberTableView.allowsMultipleSelection = true
        
        memberTableView.register(MemberTableViewCell.self, forCellReuseIdentifier: MemberTableViewCell.CellIdentifier)
    }
    
    private func setTextField() {
        searchTextField.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "btnSearch")
        imageView.image = image
        imageView.tintColor = .systemGray5
        searchTextField.leftView = imageView
    }
    
    private func setAction() {
        confirmButton.addAction(UIAction(handler: { _ in
            
            self.memberTableView.indexPathsForSelectedRows?.forEach({ indexPath in
                self.selectedMembers.append(self.contactList[indexPath.row].name)
            })
            
            NotificationCenter.default.post(name: NSNotification.Name("AddMember"), object: self.selectedMembers)
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
    }
    
    private func getContacts() {
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: key)
        
        contactStroe.requestAccess(for: .contacts) { (success, error) in
            if (success) {
                // 주소록 접근 허용
                do {
                    try! self.contactStroe.enumerateContacts(with: request, usingBlock: { (contact, stop) in
                        let name = contact.givenName
                        let familyName = contact.familyName
                        
                        var number: String
                        if contact.phoneNumbers.isEmpty {
                            number = "번호 없음"
                        } else {
                            number = (contact.phoneNumbers.first?.value.stringValue)!
                        }
                        let contactsToAppend = ContactDataModel(givenName: name, familyName: familyName, phoneNumber: number)
                        dump(contactsToAppend)
                    })
                }
            } else {
                // 주소록 권한 비허용 -> 알람 메시지
                let alert = UIAlertController(title: "알림", message: "친구 추가를 위해 연락처 연동을 허용해주세요", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { (UIAction) -> Void in
                    let settingURL = NSURL(string: UIApplication.openSettingsURLString)! as URL
                    UIApplication.shared.open(settingURL, options: [:], completionHandler: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        memberTableView.reloadData()
    }
    
    private func load() -> Data? {
        let fileNm: String = "ContactData"
        let extensionType = "json"
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            print("파일 로드 실패")
            return nil
        }
    }
}

// MARK: - UITableView Delegate

extension AddMemberViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateCount()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateCount()
    }
    
    func updateCount(){
        if let list = memberTableView.indexPathsForSelectedRows {
            count = list.count
            countLabel.text = "\(count)"
        }
    }
}

// MARK: - UITableView DataSource

extension AddMemberViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemberTableViewCell.CellIdentifier) as? MemberTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.isSelected = false
        
        cell.initCell(contactList[indexPath.row])
        
        if indexPath.row == 0 {
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 9
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        if indexPath.row == contactList.count - 1 {
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 9
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        
        return cell
    }
}

// MARK: - Network

extension AddMemberViewController {
    private func getContactData() {
        guard
            let jsonData = self.load(),
            let data = try? JSONDecoder().decode(ContactDataResponse.self, from: jsonData)
        else { return }
        contactList = data.addressData
        memberTableView.reloadData()
    }
}
