//
//  MyGroupCVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/12/10.
//

import UIKit

import SnapKit
import Then

protocol MyGroupCollectionViewCellDelegate {
    func touchUpTestButton()
    func touchUpCell(index: Int)
}

final class MyGroupCollectionViewCell: UICollectionViewCell {
    static let identifier = "MyGroupCollectionViewCell"

    // MARK: - Properties
    
    @IBOutlet weak var groupTableView: UITableView!
    
    private lazy var headerView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private lazy var testBackView = UIView().then {
        $0.backgroundColor = .gray350
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "그룹"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var countLabel = UILabel().then {
        $0.textColor = .gray200
        $0.font = .DINPro(type: .regular, size: 18)
    }
    
    private lazy var testButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray150.cgColor, cornerRadius: 12.5, bounds: true)
        $0.setTitle("테스트 하러가기", for: .normal)
        $0.setTitleColor(.gray150, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 11)
        $0.addTarget(self, action: #selector(touchUpTestButton), for: .touchUpInside)
    }
    
    var count: Int = 0 {
        didSet {
            countLabel.text = "\(count)"
            countLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var delegate: MyGroupCollectionViewCellDelegate?
    
    private var publicGroupData = [PublicGroupData]()
    
    // MARK: - Initialzier
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
        setLayout()
        bind()
    }

    // MARK: - Init UI
    
    private func configUI() {
        contentView.backgroundColor = .clear
        testBackView.makeRounded(cornerRadius: 6)
    }
    
    private func setLayout() {
        headerView.addSubviews([testBackView, titleLabel, countLabel])
        testBackView.addSubview(testButton)
        
        testBackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(18)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(65)
        }
        
        testButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.trailing.equalToSuperview().inset(22)
            $0.width.equalTo(94)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(testBackView.snp.bottom).offset(18)
            $0.leading.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.height.equalTo(23)
            $0.top.equalTo(testBackView.snp.bottom).offset(15)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        groupTableView.delegate = self
        groupTableView.dataSource = self
        
        groupTableView.backgroundColor = .background
        groupTableView.separatorStyle = .none
        groupTableView.showsVerticalScrollIndicator = false
        
        groupTableView.register(MyPublicGroupTableViewCell.self, forCellReuseIdentifier: MyPublicGroupTableViewCell.identifier)
    }
    
    internal func initCell(_ data: [PublicGroupData]) {
        publicGroupData = data
        groupTableView.reloadData()
    }
    
    // MARK: - @objc
    
    @objc func touchUpTestButton() {
        delegate?.touchUpTestButton()
    }
}

// MARK: - UITableView Delegate

extension MyGroupCollectionViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 109
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.touchUpCell(index: indexPath.row)
    }
}

// MARK: - UITableView DataSource

extension MyGroupCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publicGroupData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPublicGroupTableViewCell.identifier) as? MyPublicGroupTableViewCell else { return UITableViewCell() }
        cell.initCell(publicGroupData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
