//
//  HeaderCellNode.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/25.
//

import AsyncDisplayKit

class HeaderCellNode: ASCellNode {

    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
        self.backgroundColor = .black
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: MainNode())
        
    }
}
