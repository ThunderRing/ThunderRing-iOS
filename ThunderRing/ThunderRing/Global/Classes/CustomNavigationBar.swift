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
    
    // closebtn
//    let closeButton: UIButton = {
//        let button = UIButton()
//        button
//        return button
//    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    // MARK: - Methods
    
    init(vc: UIViewController, title: String) {
        super.init(frame: .zero)
        setUI()
        setupLayout()
        setupAction(vc: vc)
        setTitle(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = UIColor.white
    }
    
    
    private func setupLayout() {
        addSubview(backButton)
        addSubview(titleLabel)
        //addSubview(closeButton)
        addSubview(separatorView)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
//            closeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7)
            
            separatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    private func setTitle(title: String) {
        self.titleLabel.text = title
    }
    
    private func setupAction(vc: UIViewController) {
        let backAction = UIAction { _ in
//            vc.dismiss(animated: true, completion: nil)
            vc.navigationController?.popViewController(animated: true)
        }
        backButton.addAction(backAction, for: .touchUpInside)
    }
    
    func setUpTitle(title: String) {
        titleLabel.text = title
    }
}
