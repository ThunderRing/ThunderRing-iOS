//
//  TDSNavigationBar.swift
//  ThunderRing
//
//  Created by soyeon on 2022/03/04.
//

import Foundation

import SnapKit
import Then

enum ViewType {

}

final class TDSNavigationBar: UIView {
    
    // MARK: - Metric Enum
    
    public enum Metric {
        static let navigationHeight: CGFloat = 50
        static let titleTop: CGFloat = 13
        static let titleLeading: CGFloat = 25
        static let buttonLeading: CGFloat = 4
        static let buttonTrailing: CGFloat = 7
        static let buttonSize: CGFloat = 44
    }
    
    // MARK: - PageView Enum
    
    public enum PageView {
        case main
        case chat
        case lightning
        case alarm
        case mypage
        case test
        case publicGroup
        case privateGroup
        
        var title: String {
            switch self {
            case .main:
                return "어쩌고"
            case .chat:
                return "채팅"
            case .lightning:
                return "번개"
            case .alarm:
                return "알람"
            case .mypage:
                return "마이페이지"
            case .test:
                return "성향테스트"
            case .publicGroup:
                return "공개그룹"
            case .privateGroup:
                return "비공개그룹"
            }
        }
    }
    
    // MARK: - Properties
    
    private var viewController = UIViewController()
    public var backButton = BackButton()
    private var closeButton = CloseButton()
    
    private var titleLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private var viewType: PageView = .main {
        didSet {
            configUI()
        }
    }
    
    // MARK: - Initializer
    
    public init(_ viewController: UIViewController,
                view: PageView,
                backButtonIsHidden: Bool,
                closeButtonIsHidden: Bool) {
        super.init(frame: .zero)
        self.backButton = BackButton(root: viewController)
        self.closeButton = CloseButton(root: viewController)
        viewType = view
        configUI()
        setLayout()
        setBackButton(isHidden: backButtonIsHidden)
        setCloseButton(isHidden: closeButtonIsHidden)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        backgroundColor = .white
        titleLabel.text = viewType.title
    }
    
    private func setLayout() {
        addSubviews([backButton,
                     titleLabel,
                     closeButton])
        
        snp.makeConstraints {
            $0.height.equalTo(Metric.navigationHeight)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(Metric.buttonLeading)
            $0.width.height.equalTo(Metric.buttonSize)
        }
        
        titleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(25)
        }
        
        closeButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(Metric.buttonTrailing)
            $0.width.height.equalTo(Metric.buttonSize)
        }
    }
    
    // MARK: - Custom Method
    
    private func setBackButton(isHidden: Bool) {
        backButton.isHidden = isHidden
    }
    
    private func setCloseButton(isHidden: Bool) {
        closeButton.isHidden = isHidden
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
}
