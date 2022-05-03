//
//  UIViewController+.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/09.
//

import UIKit

extension UIViewController {
    func setStatusBar(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let margin = view.layoutMarginsGuide
            let statusbarView = UIView()
            statusbarView.backgroundColor = color
            statusbarView.frame = CGRect.zero
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                statusbarView.topAnchor.constraint(equalTo: view.topAnchor),
                statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
                statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                statusbarView.bottomAnchor.constraint(equalTo: margin.topAnchor)
            ])
            
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
    
    func setNavigationBar(customNavigationBarView: UIView, title: String, backBtnIsHidden: Bool, closeBtnIsHidden: Bool, bgColor: UIColor) {
        let navigationBar = CustomNavigationBar(vc: self, title: title, backBtnIsHidden: backBtnIsHidden, closeBtnIsHidden: closeBtnIsHidden, bgColor: bgColor)
        
        customNavigationBarView.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: customNavigationBarView.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: customNavigationBarView.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: customNavigationBarView.safeAreaLayoutGuide.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: customNavigationBarView.bottomAnchor)
        ])
        
        setStatusBar(.white)
    }
    
    func setModalNavigationBar(customNavigationBarView: UIView, title: String, backBtnIsHidden: Bool, closeBtnIsHidden: Bool, bgColor: UIColor) {
        let navigationBar = CustomModalNavigationBar(vc: self, title: title, backBtnIsHidden: backBtnIsHidden, closeBtnIsHidden: closeBtnIsHidden, bgColor: bgColor)
        
        customNavigationBarView.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: customNavigationBarView.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: customNavigationBarView.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: customNavigationBarView.safeAreaLayoutGuide.trailingAnchor),
            navigationBar.bottomAnchor.constraint(equalTo: customNavigationBarView.bottomAnchor)
        ])
        
        setStatusBar(.white)
    }
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: 71,
                                               y: 589,
                                               width: 233,
                                               height: 40))
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.64)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        toastLabel.setTextSpacingBy(value: -0.41)
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 3.0,
                       delay: 0.4,
                       options: .curveEaseOut,
                       animations: { toastLabel.alpha = 0.0 },
                       completion: {(isCompleted) in toastLabel.removeFromSuperview() })
    }
}
