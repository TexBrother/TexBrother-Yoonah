//
//  ProfileMenuNode.swift
//  KakaoTalk-Example
//
//  Created by SHIN YOON AH on 2021/09/01.
//

import AsyncDisplayKit
import Then

final class ProfileMenuNode: ASDisplayNode {
    // MARK: UI
    private let talkNode = MenuNode(title: "나와의 채팅", image: "profileTalkImg")
    private let editNode = MenuNode(title: "프로필 편집", image: "profileEditImg")
    private let storyNode = MenuNode(title: "카카오스토리", image: "profileStoryImg")
    
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
                                            spacing: 40.0,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [talkNode,
                                                       editNode,
                                                       storyNode])
        
        return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 75, left: 0, bottom: 58, right: 0),
                child: stackLayout
        )
    }
}
