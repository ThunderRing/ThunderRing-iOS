//
//  TestResultVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/20.
//

import UIKit

import SnapKit
import Then

final class TestResultViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private lazy var contentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private var imageView = UIImageView().then {
        $0.backgroundColor = .purple300
    }
    
    private var titleLabel = UILabel().then {
        $0.text = "상상력이 뛰어나요"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
        $0.setTextSpacingBy(value: -0.6)
    }
    
    private var descriptionView = UIView().then {
        $0.backgroundColor = .white
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 5, bounds: true)
    }
    
    private var descriptionLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
        $0.numberOfLines = 0
        $0.text = "자신만의 세계관을 만드는 것을 즐겨해서 상상력이 뛰어나죠. 아티스트의 피가 흘러 뚝딱뚝딱 만드는 모임을 좋아해요. 그래서인지 금방 그럴싸한 것들을 만들어 내곤하죠! 그래도 조심해주세요. 80데시벨 이상이 넘어가면 어지럽거든요."
        $0.setTextSpacingBy(value: -0.6)
        $0.setLineSpacing(lineSpacing: 7, lineHeightMultiple: 0)
    }
    
    private var subTitleLabel = UILabel().then {
        $0.text = "짝짝쿵짝 잘맞아요"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
        $0.setTextSpacingBy(value: -0.6)
    }
    
    private var tendencyStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 9
        $0.distribution = .fillEqually
    }
    
    private lazy var firstTendencyView = TestResultTendencyView().then {
        $0.type = .emotion
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 6, bounds: true)
    }

    private lazy var secondTendencyView = TestResultTendencyView().then {
        $0.type = .crowd
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.gray350.cgColor, cornerRadius: 6, bounds: true)
    }
    
    private var shareLabel = UILabel().then {
        $0.text = "나의 성향을 자랑 해주세요!"
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private var shareStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.distribution = .fillEqually
    }
    
    private var kakakoShareButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "KakaoTalk"), for: .normal)
    }
    
    private var facebookShareButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "Facebook"), for: .normal)
    }
    
    private lazy var searchButton = TDSButton().then {
        $0.setTitleWithStyle(title: "공개 그룹 탐색", size: 16, weight: .medium)
        $0.titleLabel?.setTextSpacingBy(value: -0.6)
        $0.isActivated = true
        $0.addTarget(self, action: #selector(touchUpSearchButton), for: .touchUpInside)
    }
    
    private var retryButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btn_return"), for: .normal)
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 26, bounds: true)
    }
    
    // MARK: - Properties
    
    private var resultDescription = "" {
        didSet {
            descriptionLabel.text = "\(resultDescription)"
            descriptionLabel.setTextSpacingBy(value: -0.6)
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .background
        setStatusBar(.background)
    }
    
    private func setLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubviews([imageView, titleLabel, descriptionView, subTitleLabel, tendencyStackView, shareLabel, shareStackView, searchButton, retryButton])
        descriptionView.addSubview(descriptionLabel)
        
        tendencyStackView.addArrangedSubview(firstTendencyView)
        tendencyStackView.addArrangedSubview(secondTendencyView)
        
        shareStackView.addArrangedSubview(kakakoShareButton)
        shareStackView.addArrangedSubview(facebookShareButton)
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.top.width.bottom.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(398)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(25)
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(153)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview().inset(14)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(25)
        }
        
        tendencyStackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(323)
            $0.height.equalTo(148)
        }
        
        shareLabel.snp.makeConstraints {
            $0.top.equalTo(tendencyStackView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(25)
        }
        
        shareStackView.snp.makeConstraints {
            $0.top.equalTo(shareLabel.snp.bottom).offset(17)
            $0.width.equalTo(90)
            $0.height.equalTo(35)
            $0.centerX.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(shareStackView.snp.bottom).offset(55)
            $0.leading.equalToSuperview().inset(26)
            $0.bottom.equalToSuperview().inset(17)
            $0.width.equalTo(265)
            $0.height.equalTo(52)
        }
        
        retryButton.snp.makeConstraints {
            $0.leading.equalTo(searchButton.snp.trailing).offset(7)
            $0.centerY.equalTo(searchButton.snp.centerY)
            $0.width.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(17)
        }
    }
    
    // MARK: - Custom Method
    
    private func updateLayout() {
        
    }
    
    // MARK: - @objc
    
    @objc func touchUpSearchButton() {
        dismiss(animated: true)
    }
}

