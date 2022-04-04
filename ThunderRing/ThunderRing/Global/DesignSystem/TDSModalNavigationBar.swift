//
//  TDSModalNavigationBar.swift
//  ThunderRing
//
//  Created by 소연 on 2022/03/23.
//

import Foundation

import SnapKit
import Then

final class TDSModalNavigationBar: UIView {
    
    // MARK: - Metric Enum
    
    public enum Metric {
        static let navigationHeight: CGFloat = 50
        static let titleTop: CGFloat = 13
        static let titleLeading: CGFloat = 25
        static let buttonLeading: CGFloat = 4
        static let buttonTrailing: CGFloat = 7
        static let buttonSize: CGFloat = 44
    }
    
    // MARK: - Properties
    
    private var viewController = UIViewController()
    public var backButton = BackButton()
    private var closeButton = CloseButton()
    
    private var titleLabel = UILabel().then {
        $0.font = .SpoqaHanSansNeo(type: .medium, size: 18)
        $0.textColor = .gray100
        $0.textAlignment = .center
    }
    
    // MARK: - Initializer
    
    public init(_ viewController: UIViewController,
                title: String,
                backButtonIsHidden: Bool,
                closeButtonIsHidden: Bool) {
        super.init(frame: .zero)
        self.backButton = BackButton(root: viewController)
        self.closeButton = CloseButton(root: viewController)
        titleLabel.text = title
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
            $0.centerX.equalToSuperview()
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
}

