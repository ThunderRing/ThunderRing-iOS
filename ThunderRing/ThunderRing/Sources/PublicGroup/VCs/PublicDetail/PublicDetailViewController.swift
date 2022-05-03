//
//  PublicDetailVC.swift
//  ThunderRing
//
//  Created by soyeon on 2022/01/28.
//

import UIKit

import SnapKit
import Then

final class PublicDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private var navigationBar = UIView().then {
        $0.backgroundColor = .background
    }
    
    private lazy var backButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpBackButton), for: .touchUpInside)
    }
    
    private lazy var settingButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.addTarget(self, action: #selector(touchUpSettingButton), for: .touchUpInside)
    }
    
    private lazy var scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.isPagingEnabled = false
    }
    
    private lazy var contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var headerView = PublicGroupDetailHeaderView().then {
        $0.delegate = self
    }
    
    private lazy var lightningButton = GroupLightningButton().then {
        $0.addTarget(self, action: #selector(touchUpLightningButton), for: .touchUpInside)
        $0.makeRounded(cornerRadius: 24)
    }
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = .gray150
    }
    
    private lazy var buttonBackView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var memberTitleLabel = UILabel().then {
        $0.text = "그룹 원"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var memberCountsLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .gray100
        $0.font = .DINPro(type: .medium, size: 16)
    }
    
    private lazy var memberSubtitleLabel = UILabel().then {
        $0.text = "명"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
    }
    
    private lazy var memberMoreButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btn_more"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpMemeberMoreButton), for: .touchUpInside)
    }
    
    private lazy var memberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.register(PrivateDetailMemberCollectionViewCell.self, forCellWithReuseIdentifier: PrivateDetailMemberCollectionViewCell.cellIdentifier)
        }
    }()
    
    private lazy var seeMoreButton = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.gray150, for: .normal)
        $0.backgroundColor = .white
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 7, bounds: true)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .regular, size: 11)
        $0.titleLabel?.setTextSpacingBy(value: -0.6)
    }
    
    private lazy var historyTitleLabel = UILabel().then {
        $0.text = "번개 기록"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var historyCountsLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = .gray100
        $0.font = .DINPro(type: .medium, size: 16)
    }
    
    private lazy var historySubtitleLabel = UILabel().then {
        $0.text = "회"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
    }
    
    private lazy var historyMoreButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btn_more"), for: .normal)
        $0.addTarget(self, action: #selector(touchUpHistoryMoreButton), for: .touchUpInside)
    }
    
    private lazy var historyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.register(PrivateDetailHistoryCollectionViewCell.self, forCellWithReuseIdentifier: PrivateDetailHistoryCollectionViewCell.CellIdentifier)
        }
    }()
    
    var isOwner: Bool = false {
        didSet {
            settingButton.setImage(isOwner ? UIImage(named: "btnSetting") : UIImage(named: "btn_dot"), for: .normal)
            settingButton.addTarget(self, action: #selector(touchUpSettingButton), for: .touchUpInside)
        }
    }
    
    var isPrivate: Bool = false
    
    var memberCounts: Int = 0 {
        didSet {
            memberCountsLabel.text = "\(memberCounts)"
        }
    }
    
    var historyCounts: Int = 0 {
        didSet {
            historyCountsLabel.text = "\(historyCounts)"
        }
    }
    
    // FIXME: - 분기처리
    var isMemberViewOpen: Bool = true {
        didSet {
            memberMoreButton.setImage(isMemberViewOpen ? UIImage(named: "btn_more") : UIImage(named: " "), for: .normal)
        }
    }
    
    var isHistoryViewOpen: Bool = true {
        didSet {
            historyMoreButton.setImage(isHistoryViewOpen ? UIImage(named: "btn_more") : UIImage(named: " "), for: .normal)
        }
    }
    
    private var members = [GroupMember]()
    private var history = [History]()
    
    var index: Int = 0
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationUI()
        configTabBarUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getDetailData()
            self.memberCollectionView.reloadData()
            self.historyCollectionView.reloadData()
        }
        configUI()
        setLayout()
        bind()
    }
    
    // MARK: - InitUI
    
    private func configNavigationUI() {
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func configTabBarUI() {
        tabBarController?.tabBar.isHidden = true
    }
    
    private func configUI() {
        view.backgroundColor = .background
        setStatusBar(.background)
    }
    
    private func setLayout() {
        view.addSubviews([scrollView, lineView, buttonBackView, navigationBar])
        buttonBackView.addSubview(lightningButton)
        navigationBar.addSubviews([backButton, settingButton])
        scrollView.addSubview(contentView)
        contentView.addSubviews([headerView,
                                 memberTitleLabel,
                                 memberCountsLabel,
                                 memberSubtitleLabel,
                                 memberMoreButton,
                                 memberCollectionView,
                                 seeMoreButton,
                                 historyTitleLabel,
                                 historyCountsLabel,
                                 historySubtitleLabel,
                                 historyMoreButton,
                                 historyCollectionView])
        
        navigationBar.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(7)
            $0.bottom.equalToSuperview().inset(1)
            $0.width.height.equalTo(48)
        }
        
        settingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(12)
            $0.bottom.equalToSuperview().inset(3)
            $0.width.height.equalTo(48)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(331)
        }
        
        memberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().inset(25)
        }
        
        memberCountsLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(44)
            $0.trailing.equalTo(memberSubtitleLabel.snp.leading).offset(-1)
        }
        
        memberSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(46)
            $0.trailing.equalToSuperview().inset(48)
        }
        
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(memberTitleLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview().inset(25)
            // TODO: - 높이값 수정
            $0.height.equalTo(185)
        }
        
        memberMoreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(7)
            $0.centerY.equalTo(memberTitleLabel.snp.centerY)
        }
        
        seeMoreButton.snp.makeConstraints {
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(26)
            $0.height.equalTo(28)
        }
        
        historyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(seeMoreButton.snp.bottom).offset(43)
            $0.leading.equalToSuperview().inset(25)
        }
        
        historyCountsLabel.snp.makeConstraints {
            $0.top.equalTo(seeMoreButton.snp.bottom).offset(42)
            $0.trailing.equalTo(historySubtitleLabel.snp.leading).offset(-1)
        }
        
        historySubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(seeMoreButton.snp.bottom).offset(44)
            $0.trailing.equalToSuperview().inset(48)
        }
        
        historyCollectionView.snp.makeConstraints {
            $0.top.equalTo(historyTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(493)
        }
        
        historyMoreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(7)
            $0.centerY.equalTo(historyTitleLabel.snp.centerY)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(56)
            $0.height.equalTo(0.5)
            $0.leading.trailing.equalToSuperview()
        }
        
        buttonBackView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
            $0.leading.trailing.equalToSuperview()
        }
        
        lightningButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func bind() {
        scrollView.delegate = self
        
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
    }
    
    // MARK: - @objc
    
    @objc func touchUpBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpLightningButton() {
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
    
    @objc func touchUpSettingButton() {
        if isOwner {
            let dvc = PrivateDetailSettingViewController()
            navigationController?.pushViewController(dvc, animated: true)
        } else {
            let optionMenu = UIAlertController()
            
            let deleteAction = UIAlertAction(title: "신고", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                print("신고")
            })
            let saveAction = UIAlertAction(title: "그룹 탈퇴", style: .destructive, handler: {
                (alert: UIAlertAction!) -> Void in
                print("그룹 탈퇴")
            })
            
            let cancelAction = UIAlertAction(title: "닫기", style: .cancel, handler: {
                (alert: UIAlertAction!) -> Void in
            })
            
            optionMenu.addAction(deleteAction)
            optionMenu.addAction(saveAction)
            optionMenu.addAction(cancelAction)
            
            present(optionMenu, animated: true, completion: nil)
        }
    }
    
    @objc func touchUpMemeberMoreButton() {
        isMemberViewOpen.toggle()
    }
    
    @objc func touchUpHistoryMoreButton() {
        isHistoryViewOpen.toggle()
    }
}

// MARK: - Custom Delegate

extension PublicDetailViewController: PublicGroupDetailHeaderViewDelegate {
    func touchUpInviteButton() {
        isOwner ? print("그룹원 초대") : print("❌가입 먼저❌")
    }
    
    func touchUpShareButton() {
        let activityVC = UIActivityViewController(activityItems: ["초대 링크 공유"], applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
        
        present(activityVC, animated: true, completion: nil)
    }
}

// MARK: - UIScrollView Delegate

extension PublicDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            navigationBar.layer.applyShadow()
        } else {
            navigationBar.layer.applyShadow(color: UIColor.clear, alpha: 0, x: 0, y: 0, blur: 0, spread: 0)
        }
    }
}

// MARK: - UICollectionView Protocol

extension PublicDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case memberCollectionView:
            let cellWidth = (collectionView.frame.width - 60) / 5
            let cellHeight = (collectionView.frame.height - 23) / 2
            return CGSize(width: cellWidth, height: cellHeight)
        case historyCollectionView:
            let cellWidth = 158
            let cellHeight = 128
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case memberCollectionView:
            return 15
        case historyCollectionView:
            return 7
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case memberCollectionView:
            return 23
        case historyCollectionView:
            return 7
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case memberCollectionView:
            return .zero
        case historyCollectionView:
            return UIEdgeInsets(top: 0, left: 25, bottom: 95, right: 24)
        default:
            return .zero
        }
    }
}

extension PublicDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case memberCollectionView:
            return members.count
        case historyCollectionView:
            return history.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case memberCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrivateDetailMemberCollectionViewCell.cellIdentifier, for: indexPath) as? PrivateDetailMemberCollectionViewCell else { return UICollectionViewCell() }
            if indexPath.item == 0 {
                cell.isOwner = true
            } else {
                cell.isOwner = false
            }
            cell.initCell(members[indexPath.item])
            return cell
        case historyCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrivateDetailHistoryCollectionViewCell.CellIdentifier, for: indexPath) as? PrivateDetailHistoryCollectionViewCell else { return UICollectionViewCell() }
            cell.initCell(history: history[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - Network

extension PublicDetailViewController {
    private func getDetailData() {
        guard
            let jsonData = self.loadPublicGroupData(),
            let data = try? JSONDecoder().decode(PublicGroupResponse.self, from: jsonData)
        else { return }
        
        headerView.groupImageName = data.publicGroupData[index].groupImageName
        headerView.groupName = data.publicGroupData[index].groupName
        headerView.groupDescription = data.publicGroupData[index].groupDescription
        headerView.tags = data.publicGroupData[index].groupTag
        headerView.groupTendency = data.publicGroupData[index].groupTendency
        
        members = data.publicGroupData[index].groupMember
        history = data.publicGroupData[index].history
        
        memberCounts = data.publicGroupData[index].groupMember.count
        historyCounts = data.publicGroupData[index].history.count
    }
}

// MARK: - Button

fileprivate final class GroupLightningButton: UIButton {
    
    private lazy var iconImage = UIImageView().then {
        $0.image = UIImage(named: "icn_lightning_new")
    }
    
    private lazy var label = UILabel().then {
        $0.text = "번개 치기"
        $0.textColor = .white
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 15)
    }
    
    init() {
        super.init(frame: .zero)
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton() {
        backgroundColor = .purple100
        addSubviews([iconImage, label])
        iconImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(127)
        }
        label.snp.makeConstraints {
            $0.leading.equalTo(iconImage.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
        }
    }
}

