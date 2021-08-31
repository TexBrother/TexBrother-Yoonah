//
//  HeaderNode.swift
//  KakaoTalk-Example
//
//  Created by SHIN YOON AH on 2021/08/31.
//

import AsyncDisplayKit
import Then

final class HeaderNode: ASDisplayNode {
    // MARK: UI
    private let titleTextNode = ASTextNode()
    private let settingButtonNode = ASButtonNode().then {
        $0.setImage(UIImage(named: "settingIcon"), for: .normal)
    }
    
    // MARK: Initializing
    init(title: String) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 0.0,
                                            justifyContent: .spaceBetween,
                                            alignItems: .start,
                                            children: [titleTextNode,
                                                       settingButtonNode])
        
        return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 15, left: 14, bottom: 16, right: 15),
                child: stackLayout
        )
    }
}
