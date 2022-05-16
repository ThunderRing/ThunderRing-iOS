//
//  TestView.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/19.
//

import UIKit

import SnapKit
import Then

class TestView: UIView {
    
    // MARK: - Properties
    
    var questionLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 22)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    var answerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
        }
    }()
    
    var question: String = "" {
        didSet {
            questionLabel.text = question
            questionLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    var answer = [String]() {
        didSet {
            answerCollectionView.reloadData()
        }
    }
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
        setCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - InitUI
    
    func configUI() {
        backgroundColor = .background
        addSubviews([questionLabel, answerCollectionView])
        answerCollectionView.reloadData()
    }
    
    func setLayout() {
        questionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(60)
        }
        
        answerCollectionView.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(29)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    func setCollectionView() {
        answerCollectionView.delegate = self
        answerCollectionView.dataSource = self
        
        answerCollectionView.register(TestAnswerCollectionViewCell.self, forCellWithReuseIdentifier: TestAnswerCollectionViewCell.cellIdentifier)
    }
}

// MARK: - UICollectionView Delegate

extension TestView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: NSNotification.Name("SelectedAnswer"), object: true)
    }
}

extension TestView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width 
        let cellHeight = CGFloat(92)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18
    }
}

extension TestView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestAnswerCollectionViewCell.cellIdentifier, for: indexPath) as? TestAnswerCollectionViewCell else { return UICollectionViewCell() }
        cell.initCell(text: answer[indexPath.item])
        return cell
    }
}

