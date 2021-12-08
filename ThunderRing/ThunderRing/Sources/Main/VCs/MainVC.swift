//
//  ViewController.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

class MainVC: UIViewController {
    
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
    
    // MARK: - Properties
    
    private var name = "파링"
    private var thunderCount = 1
    private var privateGroupCount = 4
    private var publicGroupCount = 4
    
    private var privateGroups = [[PrivateGroupDataModel]]()
    private var privateGroup1 = [PrivateGroupDataModel]()
    private var privateGroup2 = [PrivateGroupDataModel]()
    
    private var publicGroups = [PublicGroupDataModel]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        setStatusBar(.white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setCollectionView()
        setAction()
        setData()
        setGesture()
    }
}

// MARK: - Custom Methods

extension MainVC {
    private func initUI() {
        customNavigationBarView.layer.applyShadow()
        
        cardView.layer.cornerRadius = 7
        cardView.layer.masksToBounds = true
        
        imageView.initViewBorder(borderWidth: 1, borderColor: UIColor.gray300.cgColor, cornerRadius: imageView.bounds.width / 2, bounds: true)
        
        attendanceLabel.attributedText = NSMutableAttributedString()
            .regular(string: "번개 ", fontSize: 14)
            .bold("\(thunderCount)", fontSize: 14)
            .regular(string: "개가 진행 중입니다.", fontSize: 14)
        attendanceLabel.textColor = .white
        
        privateGroupCountLabel.text = "\(privateGroupCount)"
        
        publicGroupCountLabel.text = "\(publicGroupCount)"
        
    }
    
    private func setCollectionView() {
        // private group
        privateGroupCollectionView.delegate = self
        privateGroupCollectionView.dataSource = self
        
        let privateGroupNib = UINib(nibName: PrivateGroupCVC.identifier, bundle: nil)
        privateGroupCollectionView.register(privateGroupNib, forCellWithReuseIdentifier: PrivateGroupCVC.identifier)
        
        
        // public group
        let publicGroupCollectionViewlayout = publicGroupCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        publicGroupCollectionViewlayout?.scrollDirection = .horizontal
        publicGroupCollectionViewlayout?.estimatedItemSize = .zero
        
        publicGroupCollectionView.showsHorizontalScrollIndicator = false
        publicGroupCollectionView.showsVerticalScrollIndicator = false
        
        publicGroupCollectionView.delegate = self
        publicGroupCollectionView.dataSource = self
        
        let publicGroupNib = UINib(nibName: PublicGroupCVC.identifier, bundle: nil)
        publicGroupCollectionView.register(publicGroupNib, forCellWithReuseIdentifier: PublicGroupCVC.identifier)
    }
    
    private func setAction() {
        recruitButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "RecruitingVC") else { return }
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
    }
    
    private func setData() {
        // private
        privateGroup1.append(contentsOf: [
            PrivateGroupDataModel(groupImage: "imgRabbit", groupName: "양파링걸즈", memberCounts: 4, groupDescription: "우린 양파링은 킹왕짱이다"),
            PrivateGroupDataModel(groupImage: "imgCrong", groupName: "크롱", memberCounts: 4, groupDescription: "크롱크롱 크롱크크크롱")
        ])
        
        privateGroup2.append(contentsOf: [
            PrivateGroupDataModel(groupImage: "imgButterfly", groupName: "오렌지쥬스", memberCounts: 7, groupDescription: "착즙주스 사랑해"),
            PrivateGroupDataModel(groupImage: "imgJuju", groupName: "마법사쥬쥬", memberCounts: 5, groupDescription: "들어오고 싶으면 주문을 외워")
        ])
        
        privateGroups.append(privateGroup1)
        privateGroups.append(privateGroup2)
        
        // public
        publicGroups.append(contentsOf: [
            PublicGroupDataModel(groupImage: "imgRice", groupName: "Rice ball", memberCounts: 4, hashTag: "부지런한 동틀녁", memberTotalCounts: 100),
            PublicGroupDataModel(groupImage: "imgBear", groupName: "곰돌아이", memberCounts: 4, hashTag: "북적이는 오후", memberTotalCounts: 10),
            PublicGroupDataModel(groupImage: "imgNintendo", groupName: "동물의 숲", memberCounts: 3, hashTag: "감성적인 새벽녘", memberTotalCounts: 30),
            PublicGroupDataModel(groupImage: "imgDog", groupName: "이지언니", memberCounts: 4, hashTag: "사근한 오전", memberTotalCounts: 300)
        ])
    }
}

extension NSMutableAttributedString {
    func bold(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)]
        self.append(NSMutableAttributedString(string: text, attributes: attrs))
        return self
    }
    
    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
    
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case privateGroupCollectionView:
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        default:
            return .zero
        }
    }
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case privateGroupCollectionView:
            return privateGroups.count
        case publicGroupCollectionView:
            return publicGroups.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case privateGroupCollectionView:
            guard let cell = privateGroupCollectionView.dequeueReusableCell(withReuseIdentifier: PrivateGroupCVC.identifier, for: indexPath) as? PrivateGroupCVC else { return UICollectionViewCell() }
            cell.initCell(groups: privateGroups[indexPath.row])
            return cell
        case publicGroupCollectionView:
            guard let cell = publicGroupCollectionView.dequeueReusableCell(withReuseIdentifier: PublicGroupCVC.identifier, for: indexPath) as? PublicGroupCVC else { return UICollectionViewCell() }
            cell.initCell(group: publicGroups[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}


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
