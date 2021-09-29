//
//  AddCardHeaderNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

final class AddCardHeaderNode: ASDisplayNode {
    // MARK: - Properties
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            return [.font: UIFont.systemFont(ofSize: 17.0, weight: .bold),
                    .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]
        }
    }
    
    // MARK: - UI
    private lazy var starbucksCardTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "스타벅스 카드", attributes: Const.titleAttribute)
    }
    private lazy var voucherTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "카드 교환권", attributes: Const.titleAttribute)
    }
    
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
        return contentLayoutSpec()
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        let headerContentLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 100.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                starbucksCardTextNode,
                voucherTextNode
            ]
        )
        
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
//        containerInsets.top = 20.0
        containerInsets.left = 15.0
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: headerContentLayout
        )
    }
}

