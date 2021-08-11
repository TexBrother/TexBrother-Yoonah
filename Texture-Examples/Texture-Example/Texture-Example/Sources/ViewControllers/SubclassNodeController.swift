//
//  SubclassNodeController.swift
//  Texture-Example
//
//  Created by SHIN YOON AH on 2021/08/11.
//

import AsyncDisplayKit

/// Container에 들어갈 노드를 Subclass 화 시켜서 넣어주기. (Avoid Massive ViewController)
final class SubclassNodeController: ASDKViewController<TestNode> {
    
    // MARK: Initializing
    override init() {
        super.init(node: TestNode())
        self.node.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
