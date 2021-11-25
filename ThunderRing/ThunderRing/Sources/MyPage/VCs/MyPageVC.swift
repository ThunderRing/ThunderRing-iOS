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
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userInfoView: UIView!
    
    @IBOutlet weak var myPageTableView: UITableView!
    
    // MARK: - Properties
    
    private var friendCount = 0
    private var groupCount = 0
    private var thunderCount = 0
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "마이페이지", backBtnIsHidden: true, closeBtnIsHidden: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setTableView()
    }
}

// MARK: - Custom Methods

extension MyPageVC {
    func initUI() {
        profileBackView.initViewBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: profileBackView.frame.width / 2, bounds: true)
        userInfoView.initViewBorder(borderWidth: 1, borderColor: UIColor.grayStroke.cgColor, cornerRadius: 5, bounds: true)
    }
    
    func setTableView() {
        myPageTableView.delegate = self
        myPageTableView.dataSource = self
        
        myPageTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myPageTableView.separatorColor = .gray
        myPageTableView.backgroundColor = .grayBackground
        
        myPageTableView.register(MyPageAlarmTVC.self, forCellReuseIdentifier: MyPageAlarmTVC.identifier)
        myPageTableView.register(AccountTVC.self, forCellReuseIdentifier: AccountTVC.identifier)
        myPageTableView.register(QuestionTVC.self, forCellReuseIdentifier: QuestionTVC.identifier)
        myPageTableView.register(InfoTVC.self, forCellReuseIdentifier: InfoTVC.identifier)
        myPageTableView.register(LogOutTVC.self, forCellReuseIdentifier: LogOutTVC.identifier)
    }
}

extension MyPageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}

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
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTVC.identifier) as? AccountTVC else { return UITableViewCell() }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTVC.identifier) as? QuestionTVC else { return UITableViewCell() }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoTVC.identifier) as? InfoTVC else { return UITableViewCell() }
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LogOutTVC.identifier) as? LogOutTVC else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
