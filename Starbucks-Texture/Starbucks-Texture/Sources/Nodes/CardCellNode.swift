//
//  CardCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/21.
//

import AsyncDisplayKit

final class CardCellNode: ASCellNode {
    private struct Const {
        static var userAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 16.0, weight: .semibold),
                    .foregroundColor: UIColor.black]
        }
        
        static var freindsAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 14.0, weight: .semibold),
                    .foregroundColor: UIColor.black]
        }
        
        static var descAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 11.0, weight: .bold),
                    .foregroundColor: UIColor.gray]
        }
    }
    
    private lazy var profileImageNode: ASImageNode = {
        let node = ASImageNode()
        node.clipsToBounds = true
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    private lazy var nameNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    private lazy var statusMessageNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        setNeedsLayout()
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
    }
    
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 4, left: 15, bottom: 5, right: 0),
            child: contentLayoutSpec()
        )
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .horizontal,
            spacing: 11.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                profileImageNode,
                labelStackLayoutSpec()
            ]
        )
    }
    
    private func labelStackLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 7.0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [nameNode, statusMessageNode]
        )
    }
}

