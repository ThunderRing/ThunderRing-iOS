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
    
    @IBOutlet weak var cardView: CardView!
    
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
    }
}

// MARK: - Custom Methods

extension MainVC {
    private func initUI() {
        customNavigationBarView.layer.applyShadow()
        
        userNameLabel.text = "\(name)님"
        userNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        userNameLabel.textColor = .white
        
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray300.cgColor
        
        attendanceLabel.attributedText = NSMutableAttributedString()
            .regular(string: "번개 ", fontSize: 14)
            .bold("\(thunderCount)", fontSize: 14)
            .regular(string: "개가 진행 중입니다.", fontSize: 14)
        attendanceLabel.textColor = .white
        
        privateGroupCountLabel.text = "\(privateGroupCount)"
        
        publicGroupCountLabel.text = "\(publicGroupCount)"

    }
    
    private func setCollectionView() {
        let publicGroupCollectionViewlayout = publicGroupCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        publicGroupCollectionViewlayout?.scrollDirection = .horizontal
        publicGroupCollectionViewlayout?.estimatedItemSize = .zero
        
        publicGroupCollectionView.showsHorizontalScrollIndicator = false
        publicGroupCollectionView.showsVerticalScrollIndicator = false
        
        publicGroupCollectionView.delegate = self
        publicGroupCollectionView.dataSource = self
        
        let publicGroupNib = UINib(nibName: PublicGroupCVC.identifier, bundle: nil)
        publicGroupCollectionView.register(publicGroupNib, forCellWithReuseIdentifier: PublicGroupCVC.identifier)
        
        privateGroupCollectionView.delegate = self
        privateGroupCollectionView.dataSource = self

    }
    
    private func setAction() {
        recruitButton.addAction(UIAction(handler: { _ in
            guard let dvc = self.storyboard?.instantiateViewController(withIdentifier: "RecruitingVC") else { return }
            self.navigationController?.pushViewController(dvc, animated: true)
        }), for: .touchUpInside)
    }
    
    private func setData() {
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

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == privateGroupCollectionView {
            return privateGroups.count
        } else if collectionView == publicGroupCollectionView {
            return 4
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == privateGroupCollectionView {
            let privateGroupCell = privateGroupCollectionView.dequeueReusableCell(withReuseIdentifier: PrivateGroupCVC.identifier, for: indexPath) as! PrivateGroupCVC
            privateGroupCell.layer.borderWidth = 1
            privateGroupCell.layer.cornerRadius = 5
            privateGroupCell.layer.borderColor = UIColor.gray300.cgColor
            privateGroupCell.initCell(groups: privateGroups[indexPath.row])
            return privateGroupCell
            
        } else if collectionView == publicGroupCollectionView {
            let publicGroupCell = publicGroupCollectionView.dequeueReusableCell(withReuseIdentifier: PublicGroupCVC.identifier, for: indexPath) as! PublicGroupCVC
            
            return publicGroupCell
        } else {
            let publicGroupCell = publicGroupCollectionView.dequeueReusableCell(withReuseIdentifier: PublicGroupCVC.identifier, for: indexPath) as! PublicGroupCVC
            
            return publicGroupCell
        
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case privateGroupCollectionView:
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        default:
            return .zero
        }
    }
}


