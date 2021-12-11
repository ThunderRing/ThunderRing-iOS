//
//  AddMemberVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/02.
//

import UIKit

class AddMemberVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var memberTableView: UITableView!
    
    // MARK: - Properties
    
    private var members = [String]()
    private var count = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        setData()
        setTableView()
        setTextField()
        setAction()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
}

extension AddMemberVC {
    private func initUI() {
        var configuration = UIButton.Configuration.plain()
        configuration.baseForegroundColor = .lightGray
        configuration.attributedTitle = AttributedString("확인", attributes: AttributeContainer([NSAttributedString.Key.foregroundColor: UIColor.purple100, NSAttributedString.Key.font: UIFont.SpoqaHanSansNeo(type: .medium, size: 18)]))
        confirmButton.configuration = configuration
        
        countLabel.text = "\(count)명"
    }
    
    private func setData() {
        members.append(contentsOf: [
            "김소연", "윤하민", "이지원", "마예지",
            "이나영", "송보윤", "강희주", "김슬기"
        ])
    }
    
    private func setTableView() {
        memberTableView.delegate = self
        memberTableView.dataSource = self
        
        memberTableView.contentInsetAdjustmentBehavior = .never
        memberTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        
        memberTableView.backgroundColor = .background
        memberTableView.layer.borderColor = UIColor.lightGray.cgColor
        memberTableView.showsVerticalScrollIndicator = false
        memberTableView.allowsMultipleSelection = true
        
        memberTableView.register(MemberTVC.self, forCellReuseIdentifier: MemberTVC.identifier)
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
            // MARK: FIX ME
//            guard let presentingVC = self.presentingViewController as? CreatePrivateDetailVC else { return }
//            presentingVC.isCollectionViewHidden = false
            NotificationCenter.default.post(name: NSNotification.Name("AddMember"), object: nil)
            self.dismiss(animated: true, completion: nil)
        }), for: .touchUpInside)
    }
    
    
}

// MARK: - UITableView Delegate

extension AddMemberVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateCount()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        updateCount()
    }
    
    func updateCount(){
        if let list = memberTableView.indexPathsForSelectedRows {
            countLabel.text = "\(list.count)명"
        }
    }
}

extension AddMemberVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemberTVC.identifier) as? MemberTVC else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.isSelected = false
        cell.initCell(name: members[indexPath.row])
        return cell
    }
}
