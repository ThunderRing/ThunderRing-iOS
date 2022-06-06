//
//  TendencyTestCollectionViewCell.swift
//  ThunderRing
//
//  Created by 소연 on 2022/06/04.
//

import UIKit

import SnapKit
import Then

protocol TendencyTestCollectionViewCellDelegate: TendencyTestViewController {
    func touchUpAnswer(index: Int)
}

final class TendencyTestCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private var questionLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 22)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private lazy var answerCollectionView: UICollectionView = {
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
    
    var index: Int = 0
    
    var delegate: TendencyTestCollectionViewCellDelegate?
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
        setCollectionView()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .background
        addSubviews([questionLabel, answerCollectionView])
    }
    
    private func setLayout() {
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
    
    private func setCollectionView() {
        answerCollectionView.delegate = self
        answerCollectionView.dataSource = self
        
        answerCollectionView.register(TestAnswerCollectionViewCell.self, forCellWithReuseIdentifier: TestAnswerCollectionViewCell.cellIdentifier)
    }
    
    internal func initCell(_ data: TestData) {
        question = data.question
        answer = data.answer
    }
}

// MARK: - UICollectionView

extension TendencyTestCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestAnswerCollectionViewCell.cellIdentifier, for: indexPath) as! TestAnswerCollectionViewCell
        cell.selectedAnswer = indexPath.item
    }
}

extension TendencyTestCollectionViewCell: UICollectionViewDelegateFlowLayout {
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

extension TendencyTestCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestAnswerCollectionViewCell.cellIdentifier, for: indexPath) as? TestAnswerCollectionViewCell else { return UICollectionViewCell() }
        cell.initCell(text: answer[indexPath.item])
        cell.index = index
        cell.selectedAnswer = indexPath.item
        cell.delegate = self
        return cell
    }
}

extension TendencyTestCollectionViewCell: TestAnswerCollectionViewCellDelegate {
    func touchUpAnswer() {
        delegate?.touchUpAnswer(index: index)
    }
}
