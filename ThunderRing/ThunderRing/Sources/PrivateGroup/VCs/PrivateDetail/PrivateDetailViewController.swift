//
//  PrivateDetailVC.swift
//  ThunderRing
//
//  Created by 소연 on 2021/12/08.
//

import UIKit

import SnapKit
import Then

final class PrivateDetailViewController: UIViewController {
    
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
    }
    
    private lazy var scrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.isPagingEnabled = false
    }
    
    private lazy var contentView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var headerView = PrivateGroupDetailHeaderView().then {
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
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
            $0.register(PrivateDetailMemberCollectionViewCell.self, forCellWithReuseIdentifier: PrivateDetailMemberCollectionViewCell.cellIdentifier)
        }
    }()
    
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
        layout.scrollDirection = .horizontal
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
            settingButton.setImage(isOwner ? UIImage(named: "btnSetting") : UIImage(named: " "), for: .normal)
            settingButton.addTarget(self, action: #selector(touchUpSettingButton), for: .touchUpInside)
        }
    }
    
    var isPrivate: Bool = false
    
    // TODO: - 분기처리 
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
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
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
        setCollectionView()
    }
    
    // MARK: - InitUI
    
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
                                 historyTitleLabel,
                                 historyCountsLabel,
                                 historySubtitleLabel,
                                 historyMoreButton,
                                 historyCollectionView])
        
        navigationBar.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(57)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(4)
            $0.width.height.equalTo(48)
        }
        
        settingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(9)
            $0.bottom.equalToSuperview().inset(4)
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
            $0.height.equalTo(292)
        }
        
        memberTitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(23)
            $0.leading.equalToSuperview().inset(25)
        }
        
        memberCountsLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(22)
            $0.trailing.equalTo(memberSubtitleLabel.snp.leading).offset(-1)
        }
        
        memberSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(24)
            $0.trailing.equalToSuperview().inset(48)
        }
        
        memberCollectionView.snp.makeConstraints {
            $0.top.equalTo(memberTitleLabel.snp.bottom).offset(25)
            $0.leading.trailing.equalToSuperview()
            // TODO: - 높이값 수정
            $0.height.equalTo(81)
        }
        
        memberMoreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(7)
            $0.centerY.equalTo(memberTitleLabel.snp.centerY)
        }
        
        historyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(43)
            $0.leading.equalToSuperview().inset(25)
        }
        
        historyCountsLabel.snp.makeConstraints {
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(42)
            $0.trailing.equalTo(historySubtitleLabel.snp.leading).offset(-1)
        }
        
        historySubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(44)
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
    
    private func setCollectionView() {
        memberCollectionView.delegate = self
        memberCollectionView.dataSource = self
        
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        
        scrollView.delegate = self
    }
    
    private func load() -> Data? {
        let fileNm: String = "PrivateGroupData"
        let extensionType = "json"
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            print("파일 로드 실패")
            return nil
        }
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
        let dvc = PrivateDetailSettingViewController()
        dvc.modalPresentationStyle = .fullScreen
        present(dvc, animated: true)
    }
    
    @objc func touchUpMemeberMoreButton() {
        isMemberViewOpen.toggle()
    }
    
    @objc func touchUpHistoryMoreButton() {
        isHistoryViewOpen.toggle()
    }
}

// MARK: - Custom Delegate

extension PrivateDetailViewController: PrivateGroupDetailHeaderViewDelegate {
    func touchUpInviteButton() {
        isOwner ? print("그룹원 초대") : print("❌가입 먼저❌")
    }
    
    func touchUpShareButton() {
        let activityVC = UIActivityViewController(activityItems: ["초대 링크 공유"], applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.addToReadingList]
        
        present(activityVC, animated: true, completion: nil)
    }
}

// MARK: - UICollectionView Protocol

extension PrivateDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case memberCollectionView:
            let cellWidth = 53
            let cellHeight = 81
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
            return 23
        case historyCollectionView:
            return 7
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case memberCollectionView:
            return 15
        case historyCollectionView:
            return 7
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case memberCollectionView:
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        case historyCollectionView:
            return UIEdgeInsets(top: 0, left: 26, bottom: 95, right: 26)
        default:
            return .zero
        }
    }
}

extension PrivateDetailViewController: UICollectionViewDataSource {
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

// MARK: - UIScrollView Delegate

extension PrivateDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 10 {
            navigationBar.layer.applyShadow()
        } else {
            navigationBar.layer.applyShadow(color: UIColor.clear, alpha: 0, x: 0, y: 0, blur: 0, spread: 0)
        }
    }
}

// MARK: - Network

extension PrivateDetailViewController {
    private func getDetailData() {
        guard
            let jsonData = self.load(),
            let data = try? JSONDecoder().decode(PrivateGroupResponse.self, from: jsonData)
        else { return }
        
        headerView.groupImageName = data.privateGroupData[index].groupImageName
        headerView.groupName = data.privateGroupData[index].groupName
        headerView.groupDescription = data.privateGroupData[index].groupDescription
        
        members = data.privateGroupData[index].groupMember
        history = data.privateGroupData[index].history
        
        memberCountsLabel.text = "\(data.privateGroupData[index].groupMember.count)"
        historyCountsLabel.text = "\(data.privateGroupData[index].history.count)"
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

