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
    
    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setStatusBar(.white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setCollectionView()
        setAction()
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
        imageView.layer.borderColor = UIColor.grayStroke.cgColor
        
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
            dvc.modalTransitionStyle = .coverVertical
            dvc.modalPresentationStyle = .fullScreen
            self.present(dvc, animated: true, completion: nil)
        }), for: .touchUpInside)
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
            
            return 2
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
            privateGroupCell.layer.borderColor = UIColor.grayStroke.cgColor
            
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


