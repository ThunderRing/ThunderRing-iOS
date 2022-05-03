//
//  TestVC.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/17.
//

import UIKit

import SnapKit
import Then

final class TestVC: UIViewController {
    
    // MARK: - Properties
    
    private lazy var customNavigationBar = CustomNavigationBar(vc: self, title: "", backBtnIsHidden: true, closeBtnIsHidden: false, bgColor: .background)
    
    private var indexLabel = UILabel().then {
        $0.text = "1/8"
        $0.textColor = .purple100
        $0.font = .DINPro(type: .medium, size: 16)
    }
    
    private var progressView = UIProgressView().then {
        $0.progressTintColor = .purple100
        $0.progress = 0
    }
    
    private var contentScrollView = UIScrollView().then {
        $0.isScrollEnabled = false
        $0.isPagingEnabled = true
    }
    
    private var contentStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.spacing = 0
    }
    
    private var views = [TestView]()
    private var view1 = TestView()
    private var view2 = TestView()
    private var view3 = TestView()
    private var view4 = TestView()
    private var view5 = TestView()
    private var view6 = TestView()
    private var view7 = TestView()
    private var view8 = TestView()
    
    private var currentIndex = 1
    
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
        bind()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
        view.addSubviews([customNavigationBar, indexLabel, progressView, contentScrollView])
        
        contentScrollView.addSubview(contentStackView)
        
        views = [view1, view2, view3, view4, view5, view6, view7, view8]
        for view in views {
            contentStackView.addArrangedSubview(view)
            view.delegate = self
        }
        
        indexLabel.text = "\(currentIndex)/8"
    }
    
    private func setLayout() {
        customNavigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(57)
        }
        
        indexLabel.snp.makeConstraints {
            $0.top.equalTo(customNavigationBar.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(26)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(indexLabel.snp.bottom).offset(17)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(4)
        }
        
        contentScrollView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(views.count)
        }
        
        for view in views {
            view.snp.makeConstraints {
                $0.width.height.equalTo(contentScrollView)
            }
        }
    }
    
    // MARK: - Custom Method
    
    private func updateProgressViewWithAnimation(index: Int) {
        UIView.animate(withDuration: 0.5) {
            if self.progressView.progress != 0.125 * Float(index) {
                self.progressView.setProgress(0.125 * Float(index), animated: true)
            }
        }
    }
    
    private func updateScrollView() {
        contentScrollView.isScrollEnabled
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
    
    private func bind() {
        contentScrollView.delegate = self
    }
}

// MARK: - UIScrollView Delegate

extension TestVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let value = scrollView.contentOffset.x/scrollView.frame.size.width
        currentIndex = Int(value) + 1
        indexLabel.text = "\(currentIndex)/8"
        
        switch currentIndex {
        case 1:
            updateProgressViewWithAnimation(index: 1)
        case 2:
            updateProgressViewWithAnimation(index: 2)
        case 3:
            updateProgressViewWithAnimation(index: 3)
        case 4:
            updateProgressViewWithAnimation(index: 4)
        case 5:
            updateProgressViewWithAnimation(index: 5)
        case 6:
            updateProgressViewWithAnimation(index: 6)
        case 7:
            updateProgressViewWithAnimation(index: 7)
        case 8:
            updateProgressViewWithAnimation(index: 8)
        default: return
        }
    }
}

// MARK: - Custom Delegate

extension TestVC: TestViewDelegate {
    func touchUpCellView(isSelected: Bool) {
        contentScrollView.isScrollEnabled = isSelected
    }
}

// MARK: - Network

extension TestVC {
    private func getTestData() {
        guard
            let jsonData = self.load(),
            let testList = try? JSONDecoder().decode(TestResponse.self, from: jsonData)
        else { return }
        
        for i in 0...self.views.count-1 {
            views[i].question = testList.testData[i].question
            views[i].answer = testList.testData[i].answer
        }
    }
}
