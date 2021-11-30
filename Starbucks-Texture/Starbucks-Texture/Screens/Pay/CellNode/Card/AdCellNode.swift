//
//  AdCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/21.
//

import AsyncDisplayKit
import Then

final class AdCellNode: ASCellNode {
    // MARK: - UI
    private var adImageNode = ASImageNode().then {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.image = UIImage(named: "advertise")
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width, height: 70)
    }
    
    // MARK: - Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
    }
    
    // MARK: - Node Life Cycle
    override func didLoad() {
        super.didLoad()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            child: adImageNode
        )
    }
}
