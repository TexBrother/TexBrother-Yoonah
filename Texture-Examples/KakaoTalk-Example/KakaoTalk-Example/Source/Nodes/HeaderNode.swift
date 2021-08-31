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
    private let titleTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "친구", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold)])
    }
    private let settingButtonNode = ASButtonNode().then {
        $0.setImage(UIImage(named: "settingIcon"), for: .normal)
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
