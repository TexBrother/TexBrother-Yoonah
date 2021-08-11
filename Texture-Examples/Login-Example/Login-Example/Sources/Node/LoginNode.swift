//
//  LoginNode.swift
//  Login-Example
//
//  Created by SHIN YOON AH on 2021/08/11.
//

import UIKit
import AsyncDisplayKit
import Then

final class LoginNode: ASDisplayNode {
    // MARK: UI
    private let imageNode = ASImageNode().then {
        $0.image = UIImage(named: "logoImage")
        $0.contentMode = .scaleAspectFit
    }
    
    private let emailNode = ASEditableTextNode().then {
        $0.attributedPlaceholderText = NSAttributedString(string: "입력해주세요.")
        $0.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
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
                self.emailNode
            ]
        )
    }
    
    private func imageLayoutSpec() -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1.0, child: self.imageNode).styled {
            $0.flexShrink = 1.0
        }
    }
}
