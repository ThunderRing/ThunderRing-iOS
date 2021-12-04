//
//  AlarmVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

class AlarmVC: UIViewController {
    
    // MARK: - UI
    
    @IBOutlet weak var customNavigationBarView: UIView!
    
    @IBOutlet weak var proceedLabel: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    
    @IBOutlet weak var statusMovedView: UIView!
    
    @IBOutlet weak var alarmCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var currentIndex = 0
    private var proceedAlarms = [AlarmDataModel]()
    private var completeAlarms = [AlarmDataModel]()
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        setNavigationBar(customNavigationBarView: customNavigationBarView, title: "알림", backBtnIsHidden: true, closeBtnIsHidden: true, bgColor: .white)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setTextLabelGesture()
        setData()
    }
}

// MARK: - Custom Methods

extension AlarmVC {
    private func setCollectionView() {
        let alarmCollectionViewlayout = alarmCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        alarmCollectionViewlayout?.scrollDirection = .horizontal
        alarmCollectionViewlayout?.estimatedItemSize = .zero
        
        alarmCollectionView.showsHorizontalScrollIndicator = false
        alarmCollectionView.showsVerticalScrollIndicator = false
        alarmCollectionView.backgroundColor = .background
        
        alarmCollectionView.delegate = self
        alarmCollectionView.dataSource = self
        
        let proceedNib = UINib(nibName: ProceedCVC.identifier, bundle: nil)
        alarmCollectionView.register(proceedNib, forCellWithReuseIdentifier: ProceedCVC.identifier)
        
        let completeNib = UINib(nibName: CompleteCVC.identifier, bundle: nil)
        alarmCollectionView.register(completeNib, forCellWithReuseIdentifier: CompleteCVC.identifier)
    }
    
    private func setTextLabelGesture() {
        let tapProceedLabelGesture = UITapGestureRecognizer(target: self, action: #selector(tapProceedLabel))
        proceedLabel.addGestureRecognizer(tapProceedLabelGesture)
        proceedLabel.isUserInteractionEnabled = true
        
        let tapCompleteLabelGesture = UITapGestureRecognizer(target: self, action: #selector(dragToProceed))
        completeLabel.addGestureRecognizer(tapCompleteLabelGesture)
        completeLabel.isUserInteractionEnabled = true
    }
    
    private func setData() {
        proceedAlarms.append(contentsOf: [
            AlarmDataModel(isThunder: false, isLightning: true, isFailed: false, title: "스벅가서 모각공", description: "채팅방에 먼저 참가해보세요", time: "1시간 전", hashTag: ""),
            AlarmDataModel(isThunder: true, isLightning: false, isFailed: false, title: "혜화역 혼카츠 먹자", description: "오후 6:00 | 혜화역 1번 출구", time: "30분 전", hashTag: "양파링걸즈")
        ])
        
        completeAlarms.append(contentsOf: [
            AlarmDataModel(isThunder: true, isLightning: false, isFailed: false, title: "[실패] 방탈출 하실 분", description: "번개가 취소되었습니다", time: "3일 전", hashTag: ""),
            AlarmDataModel(isThunder: false, isLightning: true, isFailed: false, title: "스벅가서 모각공", description: "채팅방에 먼저 참가해보세요", time: "1시간 전", hashTag: "")
        ])
    }
}

// MARK: - @objc

extension AlarmVC {
    @objc
    private func tapProceedLabel() {
        if currentIndex == 1 {
            let indexPath = IndexPath(item: 0, section: 0)
            alarmCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = .identity
            }
            currentIndex = 0
            self.proceedLabel.textColor = .black
            self.completeLabel.textColor = .gray200
        }
    }
    
    @objc
    private func dragToProceed() {
        let indexPath = IndexPath(item: 1, section: 0)
        alarmCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        if currentIndex == 0 {
            UIView.animate(withDuration: 0.3) {
                self.statusMovedView.transform = CGAffineTransform(translationX: 165, y: 0)
            }
            currentIndex = 1
            self.proceedLabel.textColor = .gray200
            self.completeLabel.textColor = .black
        }
    }
}

// MARK: - CollectionView Delegate 

extension AlarmVC: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetIndex = targetContentOffset.pointee.x / scrollView.frame.size.width
        if targetIndex == 1 && currentIndex == 0 {
            UIView.animate(withDuration: 0.5) {
                self.statusMovedView.transform = CGAffineTransform(translationX: 165, y: 0)
            }
            currentIndex = 1
            self.proceedLabel.textColor = .gray
            self.completeLabel.textColor = .black
        } else if targetIndex == 0 && currentIndex == 1 {
            UIView.animate(withDuration: 0.5) {
                self.statusMovedView.transform = .identity
            }
            currentIndex = 0
            self.proceedLabel.textColor = .black
            self.completeLabel.textColor = .gray
        }
    }
}

extension AlarmVC: UICollectionViewDelegateFlowLayout {
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

extension AlarmVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProceedCVC.identifier, for: indexPath) as? ProceedCVC else {
                return UICollectionViewCell()
            }
            cell.setCellData(alarms: proceedAlarms)
            return cell
        } else if indexPath.row == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompleteCVC.identifier, for: indexPath) as? CompleteCVC else {
                return UICollectionViewCell()
            }
            cell.setCellData(alarms: completeAlarms)
            return cell
        }
        return UICollectionViewCell()
    }
}
