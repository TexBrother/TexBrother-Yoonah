//
//  ViewController.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/18.
//

import AsyncDisplayKit

final class ViewController: ASDKViewController<HomeNode> {
    
    // MARK: - Initalization
    override init() {
        super.init(node: HomeNode.init())
        self.node.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

