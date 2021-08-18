//
//  ViewController.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/18.
//

import AsyncDisplayKit

final class ViewController: ASDKViewController<ASDisplayNode> {
    
    // MARK: - Initalization
    override init() {
        super.init(node: ASDisplayNode())
        self.node.backgroundColor = .black
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.node.safeAreaInsets
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

