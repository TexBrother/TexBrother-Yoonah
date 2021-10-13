//
//  CouponCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/06.
//

import AsyncDisplayKit
import Then

final class CouponCellNode: ASCellNode {
    // MARK: - Const
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 15.0, weight: .bold),
                    .foregroundColor: UIColor.black]
        }
    }
    
    // MARK: - UI
    private var dividerNode = ASDisplayNode().then {
        $0.backgroundColor = .lightGray
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 10)
            $0.width = ASDimension(unit: .points, value: 1)
        }
    }
    private var couponTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "Coupon", attributes: Const.titleAttribute)
    }
    private var giftTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "e-Gift Item", attributes: Const.titleAttribute)
    }
    
    // MARK: - Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 71.0,
            justifyContent: .center,
            alignItems: .center,
            children: [
                couponTextNode,
                dividerNode,
                giftTextNode
            ]
        )
        
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 18, left: 0, bottom: 26, right: 0),
            child: stackLayout
        )
    }
}
