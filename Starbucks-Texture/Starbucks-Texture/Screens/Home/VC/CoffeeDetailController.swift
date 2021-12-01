//
//  CoffeeDetailController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/12/01.
//

import AsyncDisplayKit
import Then

final class CoffeeDetailController: ASDKViewController<ContentNode> {
    
    // MARK: - Initializing
    override init() {
        super.init(node: ContentNode.init())
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

