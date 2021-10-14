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
        UITabBar.appearance().tintColor = .systemGreen
    }
    
    private func setupTabs(){
        let homeTab = PayController()
        homeTab.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let payNavi = UINavigationController(rootViewController: PayController())
        let payTab = payNavi
        payTab.tabBarItem = UITabBarItem(title: "Pay", image: UIImage(systemName: "creditcard.fill"), tag: 1)
        
        let orderTab = PayController()
        orderTab.tabBarItem = UITabBarItem(title: "Order", image: UIImage(systemName: "arrow.up.bin.fill"), tag: 2)
        
        let giftTab = PayController()
        giftTab.tabBarItem = UITabBarItem(title: "Gift", image: UIImage(systemName: "gift.fill"), tag: 3)

        let otherTab = PayController()
        otherTab.tabBarItem = UITabBarItem(title: "Other", image: UIImage(named: "detailTabIconSelected"), tag: 4)
        
        let tabs =  [homeTab, payTab, orderTab, giftTab, otherTab]
        
        self.setViewControllers(tabs, animated: false)
        self.selectedViewController = payTab
    }
}
