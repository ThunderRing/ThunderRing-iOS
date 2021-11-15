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
        let mainStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Main, bundle: nil)
        let mainTab = mainStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Navigation)
        mainTab.tabBarItem = UITabBarItem(title: "메인", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        
        let chatStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Chat, bundle: nil)
        let chatTab = chatStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Navigation)
        chatTab.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "dialog"), selectedImage: UIImage(systemName: "dialog.fill"))
        
        let lightningStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Lightning, bundle: nil)
        let lightningTab = lightningStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Lightning)
        lightningTab.tabBarItem = UITabBarItem(title: "번개", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let alarmStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.Alarm, bundle: nil)
        let alarmTab = alarmStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Navigation)
        alarmTab.tabBarItem = UITabBarItem(title: "알림", image: UIImage(systemName: "alarm"), selectedImage: UIImage(systemName: "alarm.fill"))
        
        let myStoryboard = UIStoryboard.init(name: Const.Storyboard.Name.MyPage, bundle: nil)
        let myTab = myStoryboard.instantiateViewController(identifier: Const.ViewController.Name.Navigation)
        myTab.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        let tabs =  [mainTab, chatTab, lightningTab, alarmTab, myTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = mainTab
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is LightningVC {
            let dvc = UIStoryboard(name: Const.Storyboard.Name.Lightning, bundle: nil).instantiateViewController(withIdentifier: Const.ViewController.Name.Lightning)
            dvc.modalPresentationStyle = .fullScreen
            tabBarController.present(dvc, animated: true)
            return false
        }
        return true
    }
}


