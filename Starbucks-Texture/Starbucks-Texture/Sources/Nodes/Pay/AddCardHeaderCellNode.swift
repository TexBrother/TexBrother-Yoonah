//
//  AddCardHeaderCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

final class AddCardHeaderCellNode: ASCellNode {
    // MARK: - UI
    private lazy var starbucksCardButtonNode = ASButtonNode().then {
        $0.setTitle("스타벅스 카드", with: .systemFont(ofSize: 15, weight: .medium), with: .black, for: .normal)
    }
    private lazy var voucherButtonNode = ASButtonNode().then {
        $0.setTitle("카드 교환권", with: .systemFont(ofSize: 15, weight: .medium), with: .black, for: .normal)
    }
    private lazy var separatorNode = ASDisplayNode().then {
        $0.backgroundColor = .gray
        $0.style.minSize = CGSize(width: UIScreen.main.bounds.size.width, height: 1)
    }
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        selectionStyle = .none
    }
    
    // MARK: Node Life Cycle
    override func didLoad() {
        super.didLoad()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return contentLayoutSpec()
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        let headerContentLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 50.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                starbucksCardButtonNode,
                voucherButtonNode
            ])
        
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.top = 20.0
        containerInsets.left = 30.0
        containerInsets.bottom = 10.0
        let contentLayout = ASInsetLayoutSpec(
            insets: containerInsets,
            child: headerContentLayout
        )
        
        let lineLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                contentLayout.styled({
                    $0.flexGrow = 1.0
                }),
                separatorNode
            ])
        
        return lineLayout
    }
}

