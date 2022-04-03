//
//  MyPublicVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/12/09.
//

import UIKit

class MyPublicVC: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBOutlet weak var myGroupLabel: UILabel!
    @IBOutlet weak var lookLabel: UILabel!
    
    @IBOutlet weak var groupCollectionView: UICollectionView!
    
    @IBOutlet weak var statusMovedView: UIView!
    
    // MARK: - Properties
    
    private var currentIndex = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setCollectionView()
        setTextLabelGesture()
        setAction()
    }
}

// MARK: - Custom Methods

extension MyPublicVC {
    private func initUI() {
        topView.backgroundColor = .white
        
        groupCollectionView.backgroundColor = .background
    }
    
    private func setCollectionView() {
        let groupCollectionViewlayout = groupCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        groupCollectionViewlayout?.scrollDirection = .horizontal
        groupCollectionViewlayout?.estimatedItemSize = .zero
        
        groupCollectionView.showsHorizontalScrollIndicator = false
        groupCollectionView.showsVerticalScrollIndicator = false
        groupCollectionView.backgroundColor = .background
        
        groupCollectionView.delegate = self
        groupCollectionView.dataSource = self
        
        groupCollectionView.register(UINib(nibName: MyGroupCVC.identifier, bundle: nil), forCellWithReuseIdentifier: MyGroupCVC.identifier)
        groupCollectionView.register(UINib(nibName: LookCVC.identifier, bundle: nil), forCellWithReuseIdentifier: LookCVC.identifier)
    }
    
    private func setTextLabelGesture() {
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
            let dvc = SearchPublicGroupVC()
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
    }
}

// MARK: - @objc

extension MyPublicVC {
    @objc
    private func dragToMyGroup() {
        if currentIndex == 1 {
            let indexPath = IndexPath(item: 0, section: 0)
            groupCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = .identity
            }
            currentIndex = 0
            self.myGroupLabel.textColor = .black
            self.lookLabel.textColor = .gray200
        }
    }
    
    @objc
    private func dragToLook() {
        let indexPath = IndexPath(item: 1, section: 0)
        groupCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        if currentIndex == 0 {
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = CGAffineTransform(translationX: 165, y: 0)
            }
            currentIndex = 1
            self.myGroupLabel.textColor = .gray200
            self.lookLabel.textColor = .black
        }
    }
}

// MARK: - CollectionView Delegate

extension MyPublicVC: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetIndex = targetContentOffset.pointee.x / scrollView.frame.size.width
        if targetIndex == 1 && currentIndex == 0 {
            UIView.animate(withDuration: 0.5) {
                self.statusMovedView.transform = CGAffineTransform(translationX: 165, y: 0)
            }
            currentIndex = 1
            self.myGroupLabel.textColor = .gray
            self.lookLabel.textColor = .black
        } else if targetIndex == 0 && currentIndex == 1 {
            UIView.animate(withDuration: 0.5) {
                self.statusMovedView.transform = .identity
            }
            currentIndex = 0
            self.myGroupLabel.textColor = .black
            self.lookLabel.textColor = .gray
        }
    }
}

extension MyPublicVC: UICollectionViewDelegateFlowLayout {
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

extension MyPublicVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0 :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyGroupCVC.identifier, for: indexPath) as? MyGroupCVC else { return UICollectionViewCell() }
            cell.delegate = self
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LookCVC.identifier, for: indexPath) as? LookCVC else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - MyPublicCVC Delegate

extension MyPublicVC: MyGroupCVCDelegate {
    func touchUpTestButton() {
        let dvc = TestVC()
        dvc.modalTransitionStyle = .coverVertical
        dvc.modalPresentationStyle = .fullScreen
        present(dvc, animated: true, completion: nil)
    }
    
    func touchUpCreateButton() {
        let dvc = UINavigationController(rootViewController: CreatePublicGroupNameViewController())
        dvc.modalPresentationStyle = .fullScreen
        present(dvc, animated: true, completion: nil)
    }
    
    func touchUpCell() {
        let dvc = PublicDetailViewController()
        navigationController?.pushViewController(dvc, animated: true)
    }
}
