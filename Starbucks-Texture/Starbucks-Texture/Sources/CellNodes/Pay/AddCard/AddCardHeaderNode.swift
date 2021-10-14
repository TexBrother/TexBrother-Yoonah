//
//  AddCardHeaderNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

final class AddCardHeaderNode: ASDisplayNode {
    // MARK: - UI
    private lazy var starbucksCardButtonNode = ASButtonNode().then {
        $0.setTitle("스타벅스 카드", with: .systemFont(ofSize: 15, weight: .medium), with: .black, for: .normal)
    }
    private lazy var voucherButtonNode = ASButtonNode().then {
        $0.setTitle("카드 교환권", with: .systemFont(ofSize: 15, weight: .medium), with: .black, for: .normal)
    }
    private lazy var separatorNode = ASDisplayNode().then {
        $0.backgroundColor = .systemGray4.withAlphaComponent(0.3)
        $0.style.minSize = CGSize(width: UIScreen.main.bounds.size.width, height: 1)
        $0.view.layer.applyShadow(color: .black, alpha: 1, x: 0, y: 2, blur: 5)
    }
    
    // MARK: - Initalizing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    // MARK: - Layout
    override func layout() {
        super.layout()
    }
    
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
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0),
            child: lineLayout
        )
    }
}

