//
//  TendencyTestViewController.swift
//  ThunderRing
//
//  Created by 소연 on 2022/06/04.
//

import UIKit

import SnapKit
import Then

final class TendencyTestViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var customNavigationBar = CustomNavigationBar(vc: self, title: "", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .white)
    
    private var indexLabel = UILabel().then {
        $0.text = "1/8"
        $0.textColor = .purple100
        $0.font = .DINPro(type: .medium, size: 16)
    }
    
    private var progressView = UIProgressView().then {
        $0.progressTintColor = .purple100
        $0.progress = 0
    }
    
    private var testCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
        }
    }()
    
    private var currentIndex: Int = 0
    
    private var testList = [TestData]()
    
    private var tendency: String = ""
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.updateProgressViewWithAnimation(index: 1)
        }
        DispatchQueue.main.async {
            self.getTestData()
        }
        configUI()
        setLayout()
        setCollectionView()
        getNotification()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubviews([customNavigationBar, indexLabel, progressView, testCollectionView])
        
        customNavigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        indexLabel.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(26)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(indexLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(4)
        }
        
        testCollectionView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Custom Method
    
    private func setCollectionView() {
        testCollectionView.delegate = self
        testCollectionView.dataSource = self
        
        testCollectionView.register(TendencyTestCollectionViewCell.self, forCellWithReuseIdentifier: TendencyTestCollectionViewCell.cellIdentifier)
    }
    
    private func load() -> Data? {
        let fileNm: String = "TestData"
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
    
    private func updateProgressViewWithAnimation(index: Int) {
        UIView.animate(withDuration: 0.5) {
            if self.progressView.progress != 0.125 * Float(index) {
                self.progressView.setProgress(0.125 * Float(index), animated: true)
            }
        }
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(sendResult(_:)), name: NSNotification.Name("TestResultNoti"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushToResult(_:)), name: NSNotification.Name("LastTest"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func sendResult(_ notification: Notification) {
        let object = notification.object as! String
        tendency = object
    }
    
    @objc func pushToResult(_ notification: Notification) {
        let vc = TestResultViewController()
        vc.tendency = self.tendency
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UICollectionView

extension TendencyTestViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetIndex = targetContentOffset.pointee.x / scrollView.frame.size.width
        
        if targetIndex == 1 {
            indexLabel.text = "2/8"
            updateProgressViewWithAnimation(index: 2)
        } else if targetIndex == 2 {
            indexLabel.text = "3/8"
            updateProgressViewWithAnimation(index: 3)
        } else if targetIndex == 3 {
            indexLabel.text  = "4/8"
            updateProgressViewWithAnimation(index: 4)
        } else if targetIndex == 4 {
            indexLabel.text  = "5/8"
            updateProgressViewWithAnimation(index: 5)
        } else if targetIndex == 5 {
            indexLabel.text  = "6/8"
            updateProgressViewWithAnimation(index: 6)
        } else if targetIndex == 6 {
            indexLabel.text  = "7/8"
            updateProgressViewWithAnimation(index: 7)
        } else if targetIndex == 7 {
            indexLabel.text  = "8/8"
            updateProgressViewWithAnimation(index: 8)
        }
    }
}

extension TendencyTestViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width
        let cellHeight = collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
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

extension TendencyTestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TendencyTestCollectionViewCell.cellIdentifier, for: indexPath) as? TendencyTestCollectionViewCell else { return UICollectionViewCell() }
        cell.initCell(testList[indexPath.item])
        cell.index = indexPath.item
        return cell
    }
}

// MARK: - Network

extension TendencyTestViewController {
    private func getTestData() {
        guard
            let jsonData = self.load(),
            let testList = try? JSONDecoder().decode(TestResponse.self, from: jsonData)
        else { return }
        
        self.testList = testList.testData
        testCollectionView.reloadData()
    }
}

