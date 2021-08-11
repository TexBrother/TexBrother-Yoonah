//
//  ViewController.swift
//  Texture-Example
//
//  Created by SHIN YOON AH on 2021/08/10.
//

import AsyncDisplayKit

class ViewController: ASDKViewController<ASDisplayNode> {
    override init() {
        super.init(node: ASDisplayNode.init())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
