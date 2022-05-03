//
//  TestView.swift
//  ThunderRing
//
//  Created by soyeon on 2022/02/19.
//

import UIKit

import SnapKit
import Then

protocol TestViewDelegate: AnyObject {
    func touchUpCellView(isSelected: Bool)
}

final class TestView: UIView {
    
    // MARK: - Properties
    
    private var questionLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 22)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private var answerCollectionView: UICollectionView = {
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
    
    var answer = [String]()
    
    weak var delegate: TestViewDelegate?
    
    // MARK: - Initializer
    
    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
        bind()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - InitUI
    
    private func configUI() {
        self.backgroundColor = .white
        addSubviews([questionLabel, answerCollectionView])
        answerCollectionView.reloadData()
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
    
    private func bind() {
        answerCollectionView.delegate = self
        answerCollectionView.dataSource = self
        
        answerCollectionView.register(TestAnswerCell.self, forCellWithReuseIdentifier: TestAnswerCell.CellIdentifier)
    }
}

// MARK: - UICollectionView Delegate

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
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestAnswerCell.CellIdentifier, for: indexPath) as? TestAnswerCell else { return UICollectionViewCell() }
        cell.initCell(text: answer[indexPath.item])
        cell.delegate = self
        return cell
    }
}

extension TestView: TestAnswerCellDelegate {
    func touchUpCell(isSelected: Bool) {
        delegate?.touchUpCellView(isSelected: isSelected)
    }
}

// MARK: - Answer Cell

protocol TestAnswerCellDelegate: AnyObject {
    func touchUpCell(isSelected: Bool)
}

final class TestAnswerCell: UICollectionViewCell {
    static var CellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private lazy var textLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    weak var delegate: TestAnswerCellDelegate?
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.purple100.cgColor
                layer.borderWidth = 2
                delegate?.touchUpCell(isSelected: true)
            } else {
                layer.borderWidth = 0
                delegate?.touchUpCell(isSelected: false)
            }
        }
    }
    
    // MARK: - Initializer
    
    override func prepareForReuse() {
        delegate?.touchUpCell(isSelected: false)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - InitUI
    
    private func configUI() {
        self.backgroundColor = .gray350
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        addSubview(textLabel)
    }
    
    private func setLayout() {
        textLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    func initCell(text: String) {
        textLabel.text = text
        textLabel.setTextSpacingBy(value: -0.6)
    }
}
