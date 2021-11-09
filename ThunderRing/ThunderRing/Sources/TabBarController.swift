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
        
        setTabBar()
    }
    
    // MARK: - Custom Methods
    
    private func setTabBar() {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let mainTab = mainStoryboard.instantiateViewController(identifier: "NavigationController")
        mainTab.tabBarItem = UITabBarItem(title: "메인", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        
        
        let chatStoryboard = UIStoryboard.init(name: "Chat", bundle: nil)
        let chatTab = chatStoryboard.instantiateViewController(identifier: "ChatListVC")
        chatTab.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        
        let thunderStoryboard = UIStoryboard.init(name: "Thunder", bundle: nil)
        let thunderTab = thunderStoryboard.instantiateViewController(identifier: "ThunderVC")
        thunderTab.tabBarItem = UITabBarItem(title: "번개", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        
        let alarmStoryboard = UIStoryboard.init(name: "Alarm", bundle: nil)
        let alarmTab = alarmStoryboard.instantiateViewController(identifier: "NavigationController")
        alarmTab.tabBarItem = UITabBarItem(title: "알림", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        
        let myStoryboard = UIStoryboard.init(name: "MyPage", bundle: nil)
        let myTab = myStoryboard.instantiateViewController(identifier: "NavigationController")
        myTab.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(named: ""), selectedImage: UIImage(named: ""))
        
        let tabs =  [mainTab, chatTab, thunderTab, alarmTab, myTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = mainTab
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ThunderVC {
            let dvc = UIStoryboard(name: Const.Storyboard.Name.Thunder, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Thunder)
            dvc.modalPresentationStyle = .fullScreen
            tabBarController.present(dvc, animated: true)
            return false
        }
        return true
    }
}


