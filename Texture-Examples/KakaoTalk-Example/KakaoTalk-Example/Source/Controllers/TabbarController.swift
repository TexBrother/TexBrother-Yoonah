//
//  TabbarController.swift
//  KakaoTalk-Example
//
//  Created by SHIN YOON AH on 2021/08/31.
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        UITabBar.appearance().barTintColor = UIColor.secondarySystemBackground
        UITabBar.appearance().tintColor = .darkGray
    }
    
    func setTabBar(){
        let friendTab = ViewController()
        friendTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named:"friendTabIcon"), selectedImage: UIImage(named: "friendTabIconSelected"))
        
        let chatTab = ViewController()
        chatTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named:"messageTabIcon"), selectedImage: UIImage(named: "messageTabIconSelected"))
        
        let searchTab = ViewController()
        searchTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named:"searchTabIcon"), selectedImage: UIImage(named: "searchTabIconSelected"))
        
        let shopTab = ViewController()
        shopTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named:"shopTabIcon"), selectedImage: UIImage(named: "shopTabIconSelected"))

        let moreTab = MoreController()
        moreTab.tabBarItem = UITabBarItem(title: "", image: UIImage(named:"detailTabIcon"), selectedImage: UIImage(named: "detailTabIconSelected"))
        
        let tabs =  [friendTab, chatTab, searchTab, shopTab, moreTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = friendTab
    }
}
