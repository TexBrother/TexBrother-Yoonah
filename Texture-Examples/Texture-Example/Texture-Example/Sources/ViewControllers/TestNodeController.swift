//
//  TestNodeController.swift
//  Texture-Example
//
//  Created by SHIN YOON AH on 2021/08/11.
//

import AsyncDisplayKit
import Then

/// ViewController에서 Component를 정의 및 사용하는 경우
final class TestNodeController: ASDKViewController<ASDisplayNode> {
    // MARK: UI
    private let imageNode = ASImageNode().then {
        $0.image = UIImage(named: "image")
        $0.borderColor = UIColor.gray.cgColor
        $0.borderWidth = 1.0
        $0.cornerRadius = 15.0
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleNode = ASTextNode().then {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        $0.attributedText = NSAttributedString(
            string: "Welcome to Texture-KR",
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 15.0),
                .foregroundColor: UIColor.gray,
                .paragraphStyle: paragraphStyle
            ]
        )
    }
    
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
