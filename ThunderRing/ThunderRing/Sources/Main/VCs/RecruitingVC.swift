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
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "모집 중인 번개", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setTableView()
        
    }
    
}

extension RecruitingVC {
    func setTableView() {
        
        let nib = UINib(nibName: "RecruitingTVC",bundle: nil)
        
        recruitingTableView.delegate = self
        recruitingTableView.dataSource = self
        
        recruitingTableView.register(nib, forCellReuseIdentifier: RecruitingTVC.identifier)
    }
}

extension RecruitingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = recruitingTableView.dequeueReusableCell(withIdentifier: RecruitingTVC.identifier, for: indexPath)as! RecruitingTVC
        customCell.selectionStyle = .none
        
        return customCell
    }
    
}

extension RecruitingVC {
    func initUI(){
        customNavigationBarView.layer.applyShadow()
    }
}
