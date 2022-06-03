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
        $0.backgroundColor = .white
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
        $0.backgroundColor = .white
    }
    
    private var graphicImageView = UIImageView().then {
        $0.image = UIImage(named: "img_main")
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "번개를 치고\n천둥을 울려보세요"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 21)
        $0.numberOfLines = 2
    }
    
    private lazy var subTitleLabel = UILabel().then {
        $0.text = "누구와 약속을 잡아볼까요?"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
    }
    
    private lazy var contentScrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.isPagingEnabled = false
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .background
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
    
    private var privateGroupData = [PrivateGroupData]()
    private var publicGroupData = [PublicGroupData]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getPrivateGroupData()
            self.getPublicGroupData()
            self.privateGroupCollectionView.reloadData()
            self.publicGroupCollectionView.reloadData()
        }
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        setStatusBar(.white)
        topView.layer.applyShadow()
        
        [privateGroupHeaderView, privateGroupCollectionView, publicGroupHeaderView, publicGroupCollectionView].forEach {
            contentStackView.addArrangedSubview($0)
        }
    }
    
    private func setLayout() {
        view.addSubviews([contentScrollView, navigationBar])
        navigationBar.addSubviews([recruitingButton, searchButton])
        contentScrollView.addSubview(contentView)
        contentView.addSubviews([topView, contentStackView])
        topView.addSubviews([titleLabel, subTitleLabel, graphicImageView])
        
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
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        graphicImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.bottom.equalToSuperview()
            $0.width.height.equalTo(157)
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
        privateGroupCollectionView.register(HomeMainPrivateGroupCollectionViewCell.self, forCellWithReuseIdentifier: HomeMainPrivateGroupCollectionViewCell.cellIdentifier)
        
        publicGroupCollectionView.delegate = self
        publicGroupCollectionView.dataSource = self
        publicGroupCollectionView.register(HomeMainPublicGroupCollectionViewCell.self, forCellWithReuseIdentifier: HomeMainPublicGroupCollectionViewCell.cellIdentifier)
        publicGroupCollectionView.isMultipleTouchEnabled = true
        
        privateGroupHeaderView.delegate = self
        publicGroupHeaderView.delegate = self
        
        contentScrollView.delegate = self
    }
    
    // MARK: - @objc
    
    @objc func touchUpRecruitingButton() {
        let dvc = HomeRecruitingViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
}

// MARK: - Custom Delegate

extension HomeMainViewController: HomePrivateGroupCollectionViewCellViewDelegate {
    func touchUpEnterButton(index: Int) {
        let vc = PrivateDetailViewController()
        vc.isOwner = true
        vc.index = index
        vc.groupData = privateGroupData
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func touchUpLightningButton(index: Int) {
        let vc = CreateLightningViewController()
        let dvc = UINavigationController(rootViewController: vc)
        
        vc.index = index
        for i in 0 ... privateGroupData.count - 1 {
            vc.groupNames.append(privateGroupData[i].groupName)
            vc.groupMaxCounts.append(privateGroupData[i].groupMember.count)
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

extension HomeMainViewController: HomeMainPublicGroupCollectionViewCellViewDelegate {
    func touchUpButton(index: Int) {
        let vc = CreateLightningViewController()
        let dvc = UINavigationController(rootViewController: vc)
        
        vc.index = index
        for i in 0 ... publicGroupData.count - 1 {
            vc.groupNames.append(publicGroupData[i].groupName)
            vc.groupMaxCounts.append(publicGroupData[i].groupMaxCount)
        }
        
        dvc.modalPresentationStyle = .fullScreen
        present(dvc, animated: true)
    }
}

// MARK: - UIScrollView Delegate

extension HomeMainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            navigationBar.layer.applyShadow()
        } else {
            navigationBar.layer.applyShadow(color: UIColor.clear, alpha: 0, x: 0, y: 0, blur: 0, spread: 0)
        }
    }
}

// MARK: - UICollectionView Delegate

extension HomeMainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == publicGroupCollectionView {
            let dvc = PublicDetailViewController()
            dvc.index = indexPath.item
            dvc.isOwner = false
            navigationController?.pushViewController(dvc, animated: true)
        }
    }
}

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
            return UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26)
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainPrivateGroupCollectionViewCell.cellIdentifier, for: indexPath) as? HomeMainPrivateGroupCollectionViewCell else { return UICollectionViewCell() }
            
            if indexPath.item == 0 {
                cell.initCell(firstGroup: privateGroupData[0], secondGroup: privateGroupData[1])
                cell.firstCellView.index = 0
                cell.secondCellView.index = 1
            } else if indexPath.item == 1 {
                cell.initCell(firstGroup: privateGroupData[2], secondGroup: privateGroupData[3])
                cell.firstCellView.index = 2
                cell.secondCellView.index = 3
            } else {
                cell.initCell(firstGroup: privateGroupData[4], secondGroup: privateGroupData[5])
                cell.firstCellView.index = 4
                cell.secondCellView.index = 5
            }
            
            cell.firstCellView.delegate = self
            cell.secondCellView.delegate = self
            return cell
        case publicGroupCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMainPublicGroupCollectionViewCell.cellIdentifier, for: indexPath) as? HomeMainPublicGroupCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(group: publicGroupData[indexPath.item])
            cell.cellView.delegate = self
            cell.cellView.index = indexPath.item
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - Network

extension HomeMainViewController {
    private func getPrivateGroupData() {
        guard
            let jsonData = self.loadPrivateGroupData(),
            let data = try? JSONDecoder().decode(PrivateGroupResponse.self, from: jsonData)
        else { return }
        privateGroupData = data.privateGroupData
        privateGroupHeaderView.count = data.privateGroupData.count
    }
    
    private func getPublicGroupData() {
        guard
            let jsonData = self.loadPublicGroupData(),
            let data = try? JSONDecoder().decode(PublicGroupResponse.self, from: jsonData)
        else { return }
        publicGroupData = data.publicGroupData
        publicGroupHeaderView.count = data.publicGroupData.count
    }
}
