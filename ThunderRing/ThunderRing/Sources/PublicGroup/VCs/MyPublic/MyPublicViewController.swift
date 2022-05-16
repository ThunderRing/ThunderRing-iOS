//
//  MyPublicViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2021/12/09.
//

import UIKit

final class MyPublicViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var myGroupLabel: UILabel!
    @IBOutlet weak var lookLabel: UILabel!
    
    @IBOutlet weak var groupCollectionView: UICollectionView!
    
    @IBOutlet weak var statusMovedView: UIView!
    
    // MARK: - Properties
    
    private var currentIndex = 0
    
    private var publicGroupData = [PublicGroupData]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationUI()
        configTabBarUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getPublicGroupData()
            self.groupCollectionView.reloadData()
        }
        configUI()
        setCollectionView()
        setGesture()
        setAction()
        getNotification()
    }
    
    // MARK: - Init UI
    
    private func configTabBarUI() {
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configUI() {
        topView.backgroundColor = .white

        groupCollectionView.backgroundColor = .background
        
        myGroupLabel.setTextSpacingBy(value: -0.6)
        lookLabel.setTextSpacingBy(value: -0.6)
    }
    
    // MARK: - Custom Method
    
    private func setCollectionView() {
        let groupCollectionViewlayout = groupCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        groupCollectionViewlayout?.scrollDirection = .horizontal
        groupCollectionViewlayout?.estimatedItemSize = .zero
        
        groupCollectionView.showsHorizontalScrollIndicator = false
        groupCollectionView.showsVerticalScrollIndicator = false
        groupCollectionView.backgroundColor = .background
        
        groupCollectionView.delegate = self
        groupCollectionView.dataSource = self
        
        groupCollectionView.register(UINib(nibName: MyGroupCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MyGroupCollectionViewCell.identifier)
        groupCollectionView.register(MyOverviewCollectionViewCell.self, forCellWithReuseIdentifier: MyOverviewCollectionViewCell.cellIdentifier)
    }
    
    private func setGesture() {
        let tapMyGroupLabelGesture = UITapGestureRecognizer(target: self, action: #selector(dragToMyGroup))
        myGroupLabel.addGestureRecognizer(tapMyGroupLabelGesture)
        myGroupLabel.isUserInteractionEnabled = true
        
        let tapLookLabelGesture = UITapGestureRecognizer(target: self, action: #selector(dragToLook))
        lookLabel.addGestureRecognizer(tapLookLabelGesture)
        lookLabel.isUserInteractionEnabled = true
    }
    
    private func setAction() {
        backButton.addAction(UIAction(handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
        
        searchButton.addAction(UIAction(handler: { _ in
            let dvc = SearchPublicGroupViewController()
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
        
        plusButton.addAction(UIAction(handler: { _ in
            let dvc = UINavigationController(rootViewController: CreatePublicGroupNameViewController())
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchPublicGroup(_:)), name: NSNotification.Name("SearchPublicGroup"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func dragToMyGroup() {
        if currentIndex == 1 {
            let indexPath = IndexPath(item: 0, section: 0)
            groupCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = .identity
            }
            currentIndex = 0
            self.myGroupLabel.textColor = .gray100
            self.lookLabel.textColor = .gray150
        }
    }
    
    @objc func dragToLook() {
        let indexPath = IndexPath(item: 1, section: 0)
        groupCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        if currentIndex == 0 {
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = CGAffineTransform(translationX: 187, y: 0)
            }
            currentIndex = 1
            self.myGroupLabel.textColor = .gray150
            self.lookLabel.textColor = .gray100
        }
    }
    
    @objc func searchPublicGroup(_ notification: Notification) {
        let indexPath = IndexPath(item: 1, section: 0)
        groupCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        if currentIndex == 0 {
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = CGAffineTransform(translationX: 187, y: 0)
            }
            currentIndex = 1
            self.myGroupLabel.textColor = .gray150
            self.lookLabel.textColor = .gray100
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("DiligentTendency"), object: nil)
    }
}

// MARK: - CollectionView Delegate

extension MyPublicViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetIndex = targetContentOffset.pointee.x / scrollView.frame.size.width
        if targetIndex == 1 && currentIndex == 0 {
            UIView.animate(withDuration: 0.5) {
                self.statusMovedView.transform = CGAffineTransform(translationX: 187, y: 0)
            }
            currentIndex = 1
            self.myGroupLabel.textColor = .gray150
            self.lookLabel.textColor = .gray100
        } else if targetIndex == 0 && currentIndex == 1 {
            UIView.animate(withDuration: 0.5) {
                self.statusMovedView.transform = .identity
            }
            currentIndex = 0
            self.myGroupLabel.textColor = .gray100
            self.lookLabel.textColor = .gray150
        }
    }
}

extension MyPublicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = collectionView.frame.width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - CollectionView DataSource

extension MyPublicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyGroupCollectionViewCell.identifier, for: indexPath) as? MyGroupCollectionViewCell else { return UICollectionViewCell() }
            cell.delegate = self
            cell.count = publicGroupData.count
            cell.initCell(publicGroupData)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyOverviewCollectionViewCell.cellIdentifier, for: indexPath) as? MyOverviewCollectionViewCell else { return UICollectionViewCell() }
            cell.delegate = self
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - Custom Delegate

extension MyPublicViewController: MyGroupCollectionViewCellDelegate, MyOverviewCollectionViewCellDelegate {
    func touchUpTestButton() {
        let dvc = UINavigationController(rootViewController: TestViewController())
        dvc.modalTransitionStyle = .coverVertical
        dvc.modalPresentationStyle = .fullScreen
        present(dvc, animated: true, completion: nil)
    }
    
    func touchUpCreateButton() {
        let vc = UINavigationController(rootViewController: CreatePublicGroupNameViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func touchUpCell(index: Int) {
        let vc = PublicDetailViewController()
        vc.isMember = true
        vc.index = index
        vc.isOwner = false
        vc.isOverview = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // 둘러보기 cell
    func touhcUpTotalCell(index: Int, section: Int) {
        let vc = PublicDetailViewController()
        vc.isMember = false
        vc.index = index
        vc.isOverview = true
        vc.groupTag = 0
        vc.groupSection = section
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func touchUpTendencyCell(index: Int, groupTag: Int) {
        let vc = PublicDetailViewController()
        vc.isMember = false
        vc.index = index
        vc.isOverview = true
        vc.groupTag = 1
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Network

extension MyPublicViewController {
    private func getPublicGroupData() {
        guard
            let jsonData = self.loadPublicGroupData(),
            let data = try? JSONDecoder().decode(PublicGroupResponse.self, from: jsonData)
        else { return }
        publicGroupData = data.publicGroupData
    }
}
