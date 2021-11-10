//
//  HomeController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/10.
//

import AsyncDisplayKit
import Then

final class HomeController: ASDKViewController<ContentNode> {
    
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
        setupNavigationController()
    }
    
    // MARK: - Custom Method
    private func setupNavigationController() {
        navigationController?.isNavigationBarHidden = true
    }
}
