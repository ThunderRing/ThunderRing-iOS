//
//  TestResultVC.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/20.
//

import UIKit

import SnapKit
import Then

class TestResultVC: UIViewController {
    
    // MARK: - UI
    
    private lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
    }
    private lazy var contentView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "당신의 유형은"
        $0.textColor = .gray
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 18)
    }
    private lazy var resultLabel = UILabel().then {
        $0.text = "부지런한 동틀녁"
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 22)
    }
    
    private lazy var resultImageView = UIImageView().then {
        $0.image = UIImage(named: "image2")
    }
    
    private lazy var hashTagLabel = UILabel().then {
        $0.textColor = .purple100
        $0.font = .SpoqaHanSansNeo(type: .bold, size: 16)
    }
    
    private lazy var descriptionLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 16)
        $0.numberOfLines = 7
        $0.textAlignment = .center
    }
    
    private lazy var lineView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private lazy var shareLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    private lazy var stackView = UIStackView().then {
        $0.alignment = .fill
        $0.spacing = 20
        $0.axis = .horizontal
    }
    private lazy var kakaoShareButton = UIButton().then {
        $0.setTitle("카카오", for: .normal)
        $0.setTitleColor(.purple100, for: .normal)
        $0.setImage(UIImage(named: "kakao"), for: .normal)
    }
    private lazy var faceBookShareButton = UIButton().then {
        $0.setTitle("페이스북", for: .normal)
        $0.setTitleColor(.purple100, for: .normal)
        $0.setImage(UIImage(named: "faceBook"), for: .normal)
    }
    
    private lazy var reTestButton = UIButton().then {
        $0.setTitle("테스트 다시 하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 16)
    }
    
    private lazy var searchPublicGroupButton = UIButton().then {
        $0.setTitle("공개그룹 탐색", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .SpoqaHanSansNeo(type: .medium, size: 16)
        $0.backgroundColor = .purple100
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }
    
    // MARK: - Properties
    
    private var resultDescription =
    """
    주변의 시선을 의식하지 않고 자신만의 길을
    걸어 나가요. 꾸밈없이 내 마음을 표현하는
    것을 즐겨하죠.
    새로운 도전을 가감 없이 시도해요.
    이에 따른 위험은 기꺼이 감수하죠.
    그래서 새로운 모임을 주최하기를 좋아해요
    리더가 필요하다면 저를 찾아주세요!
    """
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        setLayout()
    }
}

extension TestResultVC {
    private func initUI() {
        view.backgroundColor = .background
        descriptionLabel.text = "\(resultDescription)"
    }
    
    private func setLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([titleLabel,
                               resultLabel, resultImageView,
                               hashTagLabel, descriptionLabel,
                               lineView,
                               shareLabel, stackView,
                               reTestButton, searchPublicGroupButton])
        stackView.addArrangedSubview(kakaoShareButton)
        stackView.addArrangedSubview(faceBookShareButton)
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { 
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.centerX.equalToSuperview()
        }
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        resultImageView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(150)
        }
        
        hashTagLabel.snp.makeConstraints {
            $0.top.equalTo(resultImageView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(hashTagLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(42)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        shareLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(38)
            $0.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(shareLabel.snp.bottom).offset(17)
            $0.centerX.equalToSuperview()
        }
        
        reTestButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(54)
            $0.centerX.equalToSuperview()
        }
        
        searchPublicGroupButton.snp.makeConstraints {
            $0.top.equalTo(reTestButton.snp.bottom).offset(23)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(38)
        }
    }
}
