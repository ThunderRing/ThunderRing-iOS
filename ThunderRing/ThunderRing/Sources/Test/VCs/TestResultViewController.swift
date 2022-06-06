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
    
    // MARK: - Properties
    
    private lazy var scrollView = UIScrollView().then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = true
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private lazy var contentView = UIView().then {
        $0.backgroundColor = .background
    }
    
    private var imageView = UIImageView().then {
        $0.image = UIImage(named: "img_buji")
    }
    
    private var userLabel = UILabel().then {
        $0.text = "썬더링님의 성향은"
        $0.setTextSpacingBy(value: -0.6)
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 17)
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
    
    private lazy var descriptionLabel = UILabel().then {
        $0.textColor = .gray100
        $0.font = .SpoqaHanSansNeo(type: .regular, size: 15)
        $0.numberOfLines = 0
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
    
    private var returnButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btn_return"), for: .normal)
        $0.initViewBorder(borderWidth: 1, borderColor: UIColor.purple100.cgColor, cornerRadius: 26, bounds: true)
    }
    
    var tendency: String = "" {
        didSet {
            if tendency == "cozy" {
                imageView.image = UIImage(named: "img_pogeun")
                
                descriptionLabel.text = "한마디로 표현하자면 '유유자적', '물아일체'에요. 리액션이 작아보이지만 막상 모임에 불러주면 누구보다 좋아해요. 무던한 성격 덕분인지 새로운 상황에 잘 적응해요. 하지만 금방 방전되거든요 저에게 에너지를 주세요."
                descriptionLabel.setTextSpacingBy(value: -0.6)
                descriptionLabel.setLineSpacing(lineSpacing: 7, lineHeightMultiple: 0)
                
                firstTendencyView.type = .soft
                secondTendencyView.type = .diligent
            } else if tendency == "emotional" {
                imageView.image = UIImage(named: "img_gamseon")
                
                descriptionLabel.text = "자신만의 세계관을 만드는 것을 즐겨해서 상상력이 뛰어나죠. 아티스트의 피가 흘러 뚝딱뚝딱 만드는 모임을 좋아해요. 그래서인지 금방 그럴싸한 것들을 만들어 내곤하죠! 그래도 조심해주세요. 80데시벨 이상이 넘어가면 어지럽거든요."
                descriptionLabel.setTextSpacingBy(value: -0.6)
                descriptionLabel.setLineSpacing(lineSpacing: 7, lineHeightMultiple: 0)
                
                firstTendencyView.type = .crowd
                secondTendencyView.type = .diligent
            } else if tendency == "soft" {
                imageView.image = UIImage(named: "img_sageun")
                
                descriptionLabel.text = "타고난 리스너로 어떤 모임이든 리액션을 담당하곤 해요. 그래서 모임을 나가 스트레스 풀며 즐거움을 느끼죠!  자상하고 세심해서 사람들이 잘 따라 활동을 주도해나가요! 그래도 조심해 주세요. 계획한 활동이 틀어지면 신경이 쓰이거든요."
                descriptionLabel.setTextSpacingBy(value: -0.6)
                descriptionLabel.setLineSpacing(lineSpacing: 7, lineHeightMultiple: 0)
                
                firstTendencyView.type = .cozy
                secondTendencyView.type = .diligent
            } else {
                imageView.image = UIImage(named: "img_buji")
                
                descriptionLabel.text = "주변의 시선을 의식하지 않고 자신만의 길을 걸어  나가요. 꾸밈없이 내 마음을 표현하는 것을 즐겨하죠. 새로운 도전을 가감 없이 시도해요. 이에 따른 위험은 기꺼이 감수하죠.  그래서 새로운 모임을 주최하기를 좋아해요. 리더가 필요하다면 저를 찾아주세요!"
                descriptionLabel.setTextSpacingBy(value: -0.6)
                descriptionLabel.setLineSpacing(lineSpacing: 7, lineHeightMultiple: 0)
                
                descriptionView.snp.updateConstraints {
                    $0.height.equalTo(178)
                }
                
                firstTendencyView.type = .cozy
                secondTendencyView.type = .crowd
            }
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
        
        contentView.addSubviews([imageView, titleLabel, descriptionView, subTitleLabel, tendencyStackView, shareLabel, shareStackView, searchButton, returnButton])
        descriptionView.addSubview(descriptionLabel)
        
        tendencyStackView.addArrangedSubview(firstTendencyView)
        tendencyStackView.addArrangedSubview(secondTendencyView)
        
        shareStackView.addArrangedSubview(kakakoShareButton)
        shareStackView.addArrangedSubview(facebookShareButton)
        
        imageView.addSubview(userLabel)
        
        scrollView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.top.width.bottom.equalToSuperview()
            $0.height.greaterThanOrEqualToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(369)
        }
        
        userLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(88)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(25)
            $0.height.equalTo(25)
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(25)
            $0.height.equalTo(178)
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
            $0.bottom.equalToSuperview().inset(51)
            $0.width.equalTo(265)
            $0.height.equalTo(52)
        }
        
        returnButton.snp.makeConstraints {
            $0.leading.equalTo(searchButton.snp.trailing).offset(7)
            $0.centerY.equalTo(searchButton.snp.centerY)
            $0.width.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(51)
        }
    }
    
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushToResult(_:)), name: NSNotification.Name("LastTest"), object: nil)
    }
    
    // MARK: - @objc
    
    @objc func touchUpSearchButton() {
        NotificationCenter.default.post(name: NSNotification.Name("SearchPublicGroup"), object: nil)
        dismiss(animated: true)
    }
    
    @objc func pushToResult(_ notification: Notification) {
        let vc = TestResultViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

