//
//  MainViewController.swift
//  ThunderRing
//
//  Created by soyeon on 2022/03/04.
//

import UIKit

import SnapKit
import Then

final class HomeMainViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = UIView().then {
        $0.backgroundColor = .background
    }
    
    private lazy var recruitingButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnRecruit"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpRecruitingButton), for: .touchUpInside)
    }
    
    private lazy var searchButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnSearch"), for: .normal)
        $0.tintColor = .gray100
    }
    
    private lazy var topView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "번개를 치고\n천둥을 울려보세요"
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 21)
        $0.numberOfLines = 2
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.text = "누구와 약속을 잡아볼까요?"
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private lazy var contentScrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.isPagingEnabled = false
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .clear
    }
    
    private lazy var contentView = UIView()
    
    private lazy var contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        $0.spacing = 0
    }
        
    private lazy var privateGroupHeaderView = HomeMainHeaderView(groupType: GroupType.privateGroup).then {
        $0.title = "비공개 그룹"
        $0.count = privateGroupData.count
    }
    
    private lazy var publicGroupHeaderView = HomeMainHeaderView(groupType: GroupType.publicGroup).then {
        $0.title = "공개 그룹"
        $0.count = publicGroupData.count
    }
    
    private lazy var privateGroupCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
        }
    }()
    
    private lazy var publicGroupCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.showsHorizontalScrollIndicator = false
        }
    }()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .background

        view.addSubviews([navigationBar, contentScrollView])

        navigationBar.addSubviews([recruitingButton, searchButton])

        contentScrollView.addSubview(contentView)

        contentView.addSubviews([topView, contentStackView])
        
        topView.addSubviews([titleLabel, subTitleLabel])
        topView.layer.applyShadow()
        
        [privateGroupHeaderView, privateGroupCollectionView, publicGroupHeaderView, publicGroupCollectionView].forEach {
            contentStackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        recruitingButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(268)
            $0.width.height.equalTo(48)
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(recruitingButton.snp.trailing)
            $0.width.height.equalTo(48)
        }
        
        contentScrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        topView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(141)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalToSuperview().inset(21)
        }

        subTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25)
            $0.top.equalTo(titleLabel.snp.bottom).offset(3)
        }

        privateGroupHeaderView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(67)
        }

        privateGroupCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(privateGroupHeaderView.snp.bottom)
            $0.height.equalTo(285)
        }

        publicGroupHeaderView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(privateGroupCollectionView.snp.bottom)
            $0.height.equalTo(67)
        }

        publicGroupCollectionView.snp.makeConstraints {
            $0.top.equalTo(publicGroupHeaderView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(733)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        privateGroupCollectionView.delegate = self
        privateGroupCollectionView.dataSource = self
        
        publicGroupCollectionView.delegate = self
        publicGroupCollectionView.dataSource = self

        privateGroupCollectionView.register(HomeMainPrivateGroupCollectionViewCell.self, forCellWithReuseIdentifier: HomeMainPrivateGroupCollectionViewCell.CellIdentifier)
        
        publicGroupCollectionView.register(HomeMainPublicGroupCollectionViewCell.self, forCellWithReuseIdentifier: HomeMainPublicGroupCollectionViewCell.CellIdentifier)
        
        privateGroupHeaderView.delegate = self
        publicGroupHeaderView.delegate = self
    }
    
    // MARK: - @objc
    
    @objc func touchUpRecruitingButton() {
        let dvc = HomeRecruitingViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - Custom Delegate

extension HomeMainViewController: HomePrivateGroupCollectionViewCellViewDelegate {
    func touchUpEnterButton() {
        let dvc = PrivateDetailViewController()
        dvc.isOwner = true
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    func touchUpLightningButton() {
        guard let vc = UIStoryboard(name: Const.Storyboard.Name.Lightning, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.LightningTitle) as? LightningTitleViewController else { return }
        let dvc = UINavigationController(rootViewController: vc)
        
        // FIXME: - index / private,public Group Data 수정
        vc.index = 0
        for i in 0 ... privateGroupData.count - 1 {
            vc.groupNames.append(privateGroupData[i].groupName)
            vc.groupMaxCounts.append(privateGroupData[i].memberCounts)
        }
        
        dvc.modalPresentationStyle = .fullScreen
        present(dvc, animated: true)
    }
}

extension HomeMainViewController: HomeMainHeaderViewDelegate {
    func touchUpPrivateGroup() {
        guard let dvc = UIStoryboard(name: Const.Storyboard.Name.MyPrivate, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.MyPrivate) as? MyPrivateViewController else { return }
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    func touchUpPublicGroup() {
        guard let dvc = UIStoryboard(name: Const.Storyboard.Name.MyPublic, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.MyPublic) as? MyPublicViewController else { return }
        navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - UICollectionView Delegate

extension HomeMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case privateGroupCollectionView:
            let cellWidth = 298
            let cellHeight = 285
            return CGSize(width: cellWidth, height: cellHeight)
        case publicGroupCollectionView:
            let cellWidth = 158
            let cellHeight = 227
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case privateGroupCollectionView:
            return UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 0)
        case publicGroupCollectionView:
            return UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)
        default:
            return .zero
        }
    }
}

extension HomeMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case privateGroupCollectionView:
            return privateGroupData.count / 2
        case publicGroupCollectionView:
            return publicGroupData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case privateGroupCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainPrivateGroupCollectionViewCell.CellIdentifier, for: indexPath) as? HomeMainPrivateGroupCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(groups: privateGroupData)
            cell.firstCellView.delegate = self
            cell.secondCellView.delegate = self
            return cell
        case publicGroupCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainPublicGroupCollectionViewCell.CellIdentifier, for: indexPath) as? HomeMainPublicGroupCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(group: publicGroupData[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
