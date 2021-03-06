//
//  TopView.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/10.
//

import AsyncDisplayKit
import QuartzCore

final class TopView: ASDisplayNode {
    // MARK: - Const
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 28.0, weight: .semibold),
                    .foregroundColor: UIColor.black]
        }
    }
    
    // MARK: - UI
    private var headerTitleNode = ASTextNode().then {
        $0.maximumNumberOfLines = 2
        $0.attributedText = NSAttributedString(string: "환절기 따뜻한 차로\n수분 충전하세요☕️", attributes: Const.titleAttribute)
    }
    
    // MARK: - Initalizing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    // MARK: - Override Method
    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        let beforeFrame = context.initialFrame(for: headerTitleNode)
        
        let afterFrame = context.finalFrame(for: headerTitleNode)
        headerTitleNode.frame = beforeFrame
        headerTitleNode.alpha = 1.0
        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: {
            self.headerTitleNode.frame = afterFrame
            self.headerTitleNode.alpha = 0.0
            self.headerTitleNode.transform = CATransform3DTranslate(self.headerTitleNode.transform, 0, -200, 0)
        }, completion: {
            context.completeTransition($0)
        })
    }
    
    // MARK: - Layout
    override func layout() {
        super.layout()
    }
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return contentInsetLayoutSpec()
    }
    
    private func contentInsetLayoutSpec() -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 100, left: 20, bottom: 0, right: 0),
            child: headerTitleNode
        )
    }
}
