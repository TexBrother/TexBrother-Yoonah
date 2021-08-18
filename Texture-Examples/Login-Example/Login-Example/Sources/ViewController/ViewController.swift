//
//  ViewController.swift
//  Login-Example
//
//  Created by SHIN YOON AH on 2021/08/11.
//

import AsyncDisplayKit

final class ViewController: ASDKViewController<LoginNode> {
    
    // MARK: - Initalization
    override init() {
        super.init(node: LoginNode.init())
        self.node.backgroundColor = .init(red: 28/255, green: 28/255, blue: 28/255, alpha: 1.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

