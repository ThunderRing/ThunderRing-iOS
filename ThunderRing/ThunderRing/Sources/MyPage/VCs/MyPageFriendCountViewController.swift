//
//  MyPageFriendCountViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/10.
//

import UIKit

import SnapKit
import Then

final class MyPageFriendCountViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var navigationBar = TDSModalNavigationBar(self, title: "친구", backButtonIsHidden: false, closeButtonIsHidden: true)
    
    private var headerView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "그룹"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 18)
    }
    
    private var friendTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .background
        $0.register(ItemCell.self, forCellReuseIdentifier: ItemCell.CellIdentifier)
        $0.separatorStyle = .none
    }
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .background
        setStatusBar(.white)
        navigationBar.layer.applyShadow()
        count = 4
    }
    
    private func setLayout() {
        view.addSubviews([friendTableView, navigationBar])
        
        headerView.addSubviews([titleLabel, countLabel])
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(23)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
        
        friendTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        friendTableView.delegate = self
        friendTableView.dataSource = self
    }
}

extension MyPageFriendCountViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.backgroundColor = .background
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57
    }
}

extension MyPageFriendCountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // FIXME: - 데이터 변경
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.CellIdentifier) as? ItemCell else { return UITableViewCell() }
        return cell
    }
}

// MARK: - Item Cell

fileprivate final class ItemCell: UITableViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private lazy var backView = UIView().then {
        $0.backgroundColor = .white
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 5, bounds: true)
    }
    
    private lazy var userImageView = UIImageView().then {
        $0.image = UIImage(named: "imgDog1")
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 17, bounds: true)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var groupTendencyView = GroupTendencyView(tagType: .emotion).then {
        $0.makeRounded(cornerRadius: 3)
    }
    
    // MARK: - Initialzier
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        contentView.backgroundColor = .background
    }
    
    private func setLayout() {
        contentView.addSubview(backView)
        backView.addSubviews([userImageView, titleLabel, groupTendencyView])
        
        backView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(3.5)
        }
        
        userImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(21)
            $0.width.equalTo(48)
            $0.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalTo(userImageView.snp.trailing).offset(14)
        }
        
        groupTendencyView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(7)
            $0.leading.equalTo(userImageView.snp.trailing).offset(14)
        }
    }
    
    // MARK: - Custom Method
    
    internal func initCell() {
        
    }
}
