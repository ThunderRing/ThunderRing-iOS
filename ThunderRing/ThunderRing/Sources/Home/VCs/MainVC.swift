//
//  ViewController.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

final class MainVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    @IBOutlet weak var recruitButton: UIButton!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var privateGroupCountLabel: UILabel!
    @IBOutlet weak var privateGroupCollectionView: UICollectionView!
    
    @IBOutlet weak var publicGroupCountLabel: UILabel!
    @IBOutlet weak var publicGroupCollectionView: UICollectionView!
    
    @IBOutlet weak var seePrivateButton: UIButton!
    @IBOutlet weak var seePublicButton: UIButton!
    
    // MARK: - Properties
    
    private var userName = "소연"
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        privateGroupCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setCollectionView()
        setAction()
        setGesture()
    }
}

// MARK: - Custom Methods

extension MainVC {
    private func initUI() {
        setStatusBar(.white)
        
        cardView.layer.cornerRadius = 7
        cardView.layer.masksToBounds = true
        
        userNameLabel.text = "\(userName)님"
        
        imageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: imageView.bounds.width / 2, bounds: true)
        
        [attendanceLabel, privateGroupCountLabel, publicGroupCountLabel].forEach {
            $0?.addCharacterSpacing()
        }
        
        privateGroupCountLabel.text = "\(privateGroupData.count)"
        publicGroupCountLabel.text = "\(publicGroupData.count)"
        attendanceLabel.attributedText = NSMutableAttributedString()
            .regular(string: "번개 ", fontSize: 14)
            .bold("\(lightningData.count)", fontSize: 14)
            .regular(string: "개가 진행 중입니다.", fontSize: 14)
        attendanceLabel.textColor = .white
    }
    
    private func setCollectionView() {
        // private group
        privateGroupCollectionView.delegate = self
        privateGroupCollectionView.dataSource = self
        
        privateGroupCollectionView.register(PrivateGroupCVC.self, forCellWithReuseIdentifier: PrivateGroupCVC.identifier)
        
        // public group
        publicGroupCollectionView.delegate = self
        publicGroupCollectionView.dataSource = self
        
        publicGroupCollectionView.backgroundColor = .background
        publicGroupCollectionView.isScrollEnabled = false
        
        let publicGroupNib = UINib(nibName: PublicGroupCVC.identifier, bundle: nil)
        publicGroupCollectionView.register(publicGroupNib, forCellWithReuseIdentifier: PublicGroupCVC.identifier)
    }
    
    private func setAction() {
        recruitButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "RecruitingVC") else { return }
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
        
        seePrivateButton.addAction(UIAction(handler: { _ in
            guard let dvc = UIStoryboard(name: Const.Storyboard.Name.MyPrivate, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.MyPrivate) as? MyPrivateVC else { return }
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
        
        seePublicButton.addAction(UIAction(handler: { _ in
            guard let dvc = UIStoryboard(name: Const.Storyboard.Name.MyPublic, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.MyPublic) as? MyPublicVC else { return }
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
    }
}

// MARK: - UICollectionView Delegate

extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case privateGroupCollectionView:
            let cellWidth = (collectionView.frame.width - 25 - 25 - 7 - 9)
            let cellHeight = (collectionView.frame.height - 7) / 2
            return CGSize(width: cellWidth, height: cellHeight)
        case publicGroupCollectionView:
            let cellWidth = (collectionView.frame.width - 25 - 25 - 11) / 2
            let cellHeight = (collectionView.frame.height - 11) / 2
            return CGSize(width: cellWidth, height: cellHeight)
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case privateGroupCollectionView:
            return 5
        case publicGroupCollectionView:
            return 11
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case privateGroupCollectionView:
            return 5
        case publicGroupCollectionView:
            return 11
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case privateGroupCollectionView:
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        case publicGroupCollectionView:
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        default:
            return .zero
        }
    }
}

// MARK: - UICollectionView DataSource

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case privateGroupCollectionView:
            return privateGroupData.count
        case publicGroupCollectionView:
            return publicGroupData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case privateGroupCollectionView:
            guard let cell = privateGroupCollectionView.dequeueReusableCell(withReuseIdentifier: PrivateGroupCVC.identifier, for: indexPath) as? PrivateGroupCVC else { return UICollectionViewCell() }
            cell.initCell(group: privateGroupData[indexPath.item])
            cell.delegate = self
            return cell
        case publicGroupCollectionView:
            guard let cell = publicGroupCollectionView.dequeueReusableCell(withReuseIdentifier: PublicGroupCVC.identifier, for: indexPath) as? PublicGroupCVC else { return UICollectionViewCell() }
            cell.initCell(group: publicGroupData[indexPath.item])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - UIGestureRecognizer Delegate

extension MainVC: UIGestureRecognizerDelegate {
    func setGesture() {
        let panGestureRecongnizer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_ :)))
        panGestureRecongnizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecongnizer)
    }
    
    @objc func panAction (_ sender : UIPanGestureRecognizer){
        let velocity = sender.velocity(in: mainScrollView)
        if abs(velocity.y) > abs(velocity.x) {
            if velocity.y < 0 {
                customNavigationBarView.layer.applyShadow(color: UIColor.black, alpha: 0.26, x: -3, y: 0, blur: 28, spread: 0)
            }
            if velocity.y > 0 && mainScrollView.contentOffset.y < 30 {
                customNavigationBarView.layer.applyShadow()
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}

// MARK: - Custom Delegate

extension MainVC: PrivateGroupCVCDelegate {
    func touchUpEnterButton() {
        let dvc = PrivateDetailViewController()
        dvc.modalPresentationStyle = .fullScreen
        present(dvc, animated: true, completion: nil)
    }
}
