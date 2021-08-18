//
//  MainNode.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/18.
//

import UIKit
import AsyncDisplayKit
import Then

final class MainNode: ASDisplayNode {
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.left = 20.0
        containerInsets.right = 20.0
        containerInsets.top = 64.0
        containerInsets.bottom = .infinity
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: contentLayoutSpec()
        )
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 5.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                HeaderNode(),
                HomeNode()
            ]
        )
    }
}
