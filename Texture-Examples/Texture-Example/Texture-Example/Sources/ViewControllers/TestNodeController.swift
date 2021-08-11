//
//  TestNodeController.swift
//  Texture-Example
//
//  Created by SHIN YOON AH on 2021/08/11.
//

import UIKit
import AsyncDisplayKit

/// ViewController에서 Component를 정의 및 사용하는 경우
final class TestNodeController: ASDKViewController<ASDisplayNode> {
    // MARK: UI
    private let imageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "image")
        node.borderColor = UIColor.gray.cgColor
        node.borderWidth = 1.0
        node.cornerRadius = 15.0
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    private let titleNode: ASTextNode = {
        let node = ASTextNode()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        node.attributedText = NSAttributedString(
            string: "Welcome to Texture-KR",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 15.0),
                .foregroundColor: UIColor.gray,
                .paragraphStyle: paragraphStyle
            ]
        )
        return node
    }()
    
    // MARK: Initializing
    override init() {
        super.init(node: ASDisplayNode())
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.node.safeAreaInsets
        containerInsets.left += 15.0
        containerInsets.right += 15.0
        containerInsets.top = containerInsets.bottom
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: self.contentLayoutSpec()
        )
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                self.imageLayoutSpec(),
                self.titleNode
            ]
        )
    }
    
    private func imageLayoutSpec() -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1.0, child: self.imageNode).styled {
            $0.flexShrink = 1.0
        }
    }
}
