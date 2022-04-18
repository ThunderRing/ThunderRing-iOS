//
//  PublicGroupDetailHeaderView.swift
//  ThunderRing
//
//  Created by 소연 on 2022/04/04.
//

import UIKit

import SnapKit
import Then

protocol PublicGroupDetailHeaderViewDelegate: AnyObject {
    func touchUpInviteButton()
    func touchUpShareButton()
}

final class PublicGroupDetailHeaderView: UIView {
    
    // MARK: - Properties
    
    private lazy var groupImageView = UIImageView().then {
        $0.image = UIImage(named: "imgDog1")
    }
    
    private lazy var groupTendencyView = GroupTendencyView(tagType: .emotion).then {
        $0.makeRounded(cornerRadius: 3)
    }
    
    private lazy var groupNameLabel = UILabel().then {
        $0.text = "그룹이름"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 20)
    }
    
    private lazy var groupDescriptionLabel = UILabel().then {
        $0.text = "그룹상세설명"
        $0.textColor = .gray150
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 14)
    }
    
    private lazy var groupTagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.isScrollEnabled = false
        }
    }()
    
    private lazy var buttonBackView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var inviteButton = UIButton().then {
        $0.setTitle("그룹원 초대", for: .normal)
        $0.setTitleColor(.gray100, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 14)
        $0.addTarget(self, action: #selector(touchUpInviteButton), for: .touchUpInside)
    }
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = .gray300
    }
    
    private lazy var shareButton = UIButton().then {
        $0.setTitle("초대 링크 공유", for: .normal)
        $0.setTitleColor(.purple100, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 14)
        $0.addTarget(self, action: #selector(touchUpShareButton), for: .touchUpInside)
    }
    
    weak var delegate: PublicGroupDetailHeaderViewDelegate?
    
    var groupTendency: String = "" {
        didSet {
            groupTendencyView.tagType = .emotion
        }
    }
    
    var groupName: String = "" {
        didSet {
            groupNameLabel.text = groupName
        }
    }
    
    var groupDescription: String = "" {
        didSet {
            groupDescriptionLabel.text = groupDescription
        }
    }
    
    var tags = [String]()
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        DispatchQueue.main.async {
            self.groupTagCollectionView.reloadData()
        }
        configUI()
        setLayout()
        setCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    
    private func configUI() {
        backgroundColor = .background
        
        buttonBackView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 10, bounds: true)
        
        groupImageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: 33, bounds: true)
        
        groupTendencyView.tagType = .emotion
        groupTendencyView.snp.updateConstraints {
            $0.width.equalTo(95)
        }
    }
    
    private func setLayout() {
        addSubviews([groupImageView,
                     groupTendencyView,
                     groupNameLabel,
                     groupDescriptionLabel,
                     groupTagCollectionView,
                     buttonBackView])
        buttonBackView.addSubviews([inviteButton, lineView, shareButton])
        
        groupImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(21)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(98)
            $0.height.equalTo(100)
        }
        
        groupTendencyView.snp.makeConstraints {
            $0.top.equalTo(groupImageView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(21)
        }
        
        groupNameLabel.snp.makeConstraints {
            $0.top.equalTo(groupTendencyView.snp.bottom).offset(22)
            $0.centerX.equalToSuperview()
        }
        
        groupDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(groupNameLabel.snp.bottom).offset(7)
            $0.centerX.equalToSuperview()
        }
        
        groupTagCollectionView.snp.makeConstraints {
            $0.top.equalTo(groupDescriptionLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(152)
            $0.height.equalTo(21)
        }
        
        buttonBackView.snp.makeConstraints {
            $0.top.equalTo(groupTagCollectionView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(61)
            $0.height.equalTo(44)
        }
        
        inviteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(31)
        }
        
        lineView.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(13)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview().inset(12)
            $0.trailing.equalToSuperview().inset(23)
        }
    }
    
    // MARK: - Custom Method
    
    private func setCollectionView() {
        groupTagCollectionView.delegate = self
        groupTagCollectionView.dataSource = self
        
        groupTagCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.CellIdentifier)
    }
    
    private func calculateCellWidth(text: String) -> CGFloat {
        let label = UILabel()
        label.text = "#\(text)"
        label.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        label.setTextSpacingBy(value: -0.6)
        label.sizeToFit()
        return label.frame.width + 12
    }
    
    // MARK: - @objc
    
    @objc func touchUpInviteButton() {
        delegate?.touchUpInviteButton()
    }
    
    @objc func touchUpShareButton() {
        delegate?.touchUpShareButton()
    }
}

// MARK: - UICollectionView Protocols

extension PublicGroupDetailHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: calculateCellWidth(text: tags[indexPath.item]), height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension PublicGroupDetailHeaderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.CellIdentifier, for: indexPath) as? ItemCell else { return UICollectionViewCell() }
        cell.initCell(tag: tags[indexPath.item])
        return cell
    }
}

// MARK: - Item Cell

fileprivate final class ItemCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "#태그"
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 13)
        $0.setTextSpacingBy(value: -0.6)
    }
    
    // MARK: - Initialzier
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        contentView.backgroundColor = UIColor(red: 198.0 / 255.0, green: 198.0 / 255.0, blue: 198.0 / 255.0, alpha: 0.27)
        contentView.makeRounded(cornerRadius: 4)
    }
    
    private func setLayout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(6)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    internal func initCell(tag: String) {
        titleLabel.text = "#\(tag)"
        titleLabel.setTextSpacingBy(value: -0.6)
    }
}

