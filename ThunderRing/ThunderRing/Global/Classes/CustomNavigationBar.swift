//
//  CustomNavi.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

class CustomNavigationBar: UIView {
    
    // MARK: - Properties
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    // MARK: - Methods
    
    init(vc: UIViewController, title: String, backBtnIsHidden: Bool) {
        super.init(frame: .zero)
        
        initUI()
        initLayout()
        initAction(vc: vc)
        initTitle(title: title)
        initBackButton(backBtnIsHidden: backBtnIsHidden)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        self.backgroundColor = UIColor.white
    }
    
    private func initLayout() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(separatorView)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
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
    }
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
    private func initBackButton(backBtnIsHidden: Bool) {
        backButton.isHidden = backBtnIsHidden
    }
}
