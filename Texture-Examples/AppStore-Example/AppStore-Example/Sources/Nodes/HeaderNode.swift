//
//  HeaderNode.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/18.
//

import AsyncDisplayKit

final class HeaderNode: ASDisplayNode {
    // MARK: UI
    private let dateTextNode = ASTextNode().then {
        let dateFormatter = DateFormatter()
        let today = Date()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "M월 dd일 EEEE"
        $0.attributedText = NSAttributedString(string: dateFormatter.string(from: today), attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
    }
    private let todayTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "투데이", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 28)])
    }
    private let profileButtonNode = ASButtonNode().then {
        $0.setImage(UIImage(named: "appstoreProfileImg"), for: .normal)
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
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 232.0,
            justifyContent: .spaceBetween,
            alignItems: .end,
            children: [
                dateLayoutSpec(),
                profileImageLayoutSpec()
            ]
        )
    }
    
    private func dateLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 2.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                dateTextNode,
                todayTextNode
            ]
        )
    }
    
    private func profileImageLayoutSpec() -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1.0, child: profileButtonNode).styled {
            $0.flexShrink = 1.0
        }
    }
}
