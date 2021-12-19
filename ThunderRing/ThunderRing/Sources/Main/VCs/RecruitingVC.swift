//
//  RecruitingVC.swift
//  ThunderRing
//
//  Created by HM on 2021/11/28.
//

import UIKit

class RecruitingVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var recruitingTableView: UITableView!
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "모집 중인 번개", backBtnIsHidden: false, closeBtnIsHidden: true, bgColor: .background)
        setStatusBar(.background)
        
        recruitingTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setTableView()
    }
    
}

extension RecruitingVC {
    func initUI(){
        view.backgroundColor = .background
        customNavigationBarView.layer.applyShadow()
    }
    
    func setTableView() {
        recruitingTableView.delegate = self
        recruitingTableView.dataSource = self
        
        recruitingTableView.contentInset = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0)
        
        let nib = UINib(nibName: "RecruitingTVC",bundle: nil)
        recruitingTableView.register(nib, forCellReuseIdentifier: RecruitingTVC.identifier)
    }
}

extension RecruitingVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 222
    }
}

extension RecruitingVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lightningDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecruitingTVC.identifier, for: indexPath) as? RecruitingTVC else { return UITableViewCell() }
        cell.recruitingDelegate = self
        cell.selectionStyle = .none
        cell.initCell(lightning: lightningDatas[indexPath.row])
        return cell
    }
}

extension RecruitingVC : RecruitingCellDelegate {
    func touchUpPlus() {
        guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "JoinVC") as? JoinVC else { return }
        dvc.modalTransitionStyle = .crossDissolve
        dvc.modalPresentationStyle = .overCurrentContext
        self.present(dvc, animated: true, completion: nil)
    }
}
