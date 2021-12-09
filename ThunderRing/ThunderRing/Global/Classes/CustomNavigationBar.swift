//
//  CustomNavi.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btnBack"), for: .normal)
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray100
        label.font = .SpoqaHanSansNeo(type: .medium, size: 18)
        return label
    }()
    
//    let separatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .gray
//        return view
//    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icnClose"), for: .normal)
        return button
    }()
    
    // MARK: - Methods
    
    init(vc: UIViewController, title: String, backBtnIsHidden: Bool, closeBtnIsHidden: Bool, bgColor: UIColor) {
        super.init(frame: .zero)
        
        initUI(bgColor: bgColor)
        initLayout()
        initAction(vc: vc)
        initTitle(title: title)
        initBackButton(backBtnIsHidden: backBtnIsHidden)
        initCloseButton(closeBtnIsHidden: closeBtnIsHidden)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI(bgColor: UIColor) {
        self.backgroundColor = bgColor
    }
    
    private func initLayout() {
        addSubview(backButton)
        addSubview(titleLabel)
//        addSubview(separatorView)
        addSubview(closeButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        separatorView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
//            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
            
            closeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -9),
        ])
    }
    
    private func initTitle(title: String) {
        self.titleLabel.text = title
    }
    
    private func initAction(vc: UIViewController) {
        let backAction = UIAction { _ in
            vc.navigationController?.popViewController(animated: true)
        }
        backButton.addAction(backAction, for: .touchUpInside)
        
        let closeAction = UIAction { _ in
            vc.dismiss(animated: true, completion: nil)
        }
        closeButton.addAction(closeAction, for: .touchUpInside)
    }
    
    private func initBackButton(backBtnIsHidden: Bool) {
        backButton.isHidden = backBtnIsHidden
    }
    
    private func initCloseButton(closeBtnIsHidden: Bool) {
        closeButton.isHidden = closeBtnIsHidden
    }
}
