//
//  TabbarController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/21.
//

import UIKit

class TabbarController: UITabBarController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupTabs()
    }
    
    // MARK: - Custom Method
    private func configUI() {
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor.secondarySystemBackground
    }
    
    private func setupTabs(){
        let homeNavi = UINavigationController(rootViewController: HomeController())
        let homeTab = homeNavi
        homeTab.tabBarItem = UITabBarItem(title: "", image: IconLiteral.btnHomeUnSelected, selectedImage: IconLiteral.btnHomeSelected)
        
        let payNavi = UINavigationController(rootViewController: PayController())
        let payTab = payNavi
        payTab.tabBarItem = UITabBarItem(title: "", image: IconLiteral.btnPayUnSelected, selectedImage: IconLiteral.btnPaySelected)
        
        let orderTab = PayController()
        orderTab.tabBarItem = UITabBarItem(title: "", image: IconLiteral.btnOrderUnSelected, selectedImage: IconLiteral.btnOrderSelected)
        
        let giftTab = PayController()
        giftTab.tabBarItem = UITabBarItem(title: "", image: IconLiteral.btnGiftUnSelected, selectedImage: IconLiteral.btnGiftSelected)

        let otherTab = PayController()
        otherTab.tabBarItem = UITabBarItem(title: "", image: IconLiteral.btnOtherUnSelected, selectedImage: IconLiteral.btnOtherSelected)
        
        let tabs =  [homeTab, payTab, orderTab, giftTab, otherTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = homeTab
    }
}
