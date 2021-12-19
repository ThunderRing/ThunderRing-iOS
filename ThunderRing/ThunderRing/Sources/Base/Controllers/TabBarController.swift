//
//  TabBarController.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        initUI()
        setTabBar()
        getNotification()
    }
    
    // MARK: - Custom Methods
    
    private func initUI() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor(red: 157.0 / 255.0, green: 157.0 / 255.0, blue: 157.0 / 255.0, alpha: 1.0)
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.tabBar.standardAppearance = appearance;
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
    }
    
    private func setTabBar() {
        let mainStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Main, bundle: nil)
        let mainTab = mainStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Navigation)
        mainTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "homeIn"), selectedImage: UIImage(named: "home"))
        
        let chatStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Chat, bundle: nil)
        let chatTab = chatStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Navigation)
        chatTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "chatIn"), selectedImage: UIImage(named: "chat"))
        
        let lightningStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Lightning, bundle: nil)
        let lightningTab = lightningStoryboard.instantiateViewController(identifier: Const.ViewController.Name.ModalNavigation)
        lightningTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "thunder"), selectedImage: UIImage(named: "thunder"))
        
        let alarmStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Alarm, bundle: nil)
        let alarmTab = alarmStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Navigation)
        alarmTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "alarmIn"), selectedImage: UIImage(named: "alarm"))
        
        let myStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.MyPage, bundle: nil)
        let myTab = myStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Navigation)
        myTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "mypageIn"), selectedImage: UIImage(named: "mypage"))
        
        let tabs =  [mainTab, chatTab, lightningTab, alarmTab, myTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = mainTab
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ModalNavigationController {
            let dvc = UIStoryboard(name: Const.Storyboard.Name.Lightning, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.ModalNavigation)
            dvc.modalPresentationStyle = .fullScreen
            tabBarController.present(dvc, animated: true)
            return false
        }
        return true
    }
}

extension TabBarController {
    private func getNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setSelectedTab(_:)), name: NSNotification.Name("EnterAppByPush"), object: nil)
    }
    
    @objc
    func setSelectedTab(_ notification: Notification) {
        print("알람 탭으로 이동")
        self.selectedIndex = 3
    }
}

