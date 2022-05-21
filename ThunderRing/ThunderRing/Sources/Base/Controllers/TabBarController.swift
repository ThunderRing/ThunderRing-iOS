//
//  TabBarController.swift
//  ThunderRing
//
//  Created by soyeon on 2021/11/07.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        configUI()
        setTabBar()
        getNotification()
    }
    
    // MARK: - Custom Methods
    
    private func configUI() {
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .gray150
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        self.tabBar.standardAppearance = appearance;
        self.tabBar.scrollEdgeAppearance = self.tabBar.standardAppearance
    }
    
    private func setTabBar() {
        let homeTab = UINavigationController(rootViewController: HomeMainViewController())
        homeTab.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "tap_home_inactive"), selectedImage: UIImage(named: "tap_home_active"))
        
        let chatTab = UINavigationController(rootViewController: ChatMainViewController())
        chatTab.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: "tap_chat_inactive"), selectedImage: UIImage(named: "tap_chat_active"))
        
        let lightningStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Lightning, bundle: nil)
        let lightningTab = lightningStoryboard.instantiateViewController(identifier: Const.ViewController.Name.ModalNavigation)
        lightningTab.tabBarItem = UITabBarItem(title: "번개", image: UIImage(named: "tap_lightning"), selectedImage: UIImage(named: "tap_lightning"))
        
        let alarmTab = UINavigationController(rootViewController: AlarmMainViewController())
        alarmTab.tabBarItem = UITabBarItem(title: "알림", image: UIImage(named: "tap_alarm_inactive"), selectedImage: UIImage(named: "tap_alarm_active"))
        
        let myStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.MyPage, bundle: nil)
        let myTab = myStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Navigation)
        myTab.tabBarItem = UITabBarItem(title: "프로필", image: UIImage(named: "tap_mypage_inactive"), selectedImage: UIImage(named: "tap_mypage_active"))
        
        let tabs = [homeTab, chatTab, lightningTab, alarmTab, myTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = homeTab
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
    
    @objc func setSelectedTab(_ notification: Notification) {
        self.selectedIndex = 3
    }
}

