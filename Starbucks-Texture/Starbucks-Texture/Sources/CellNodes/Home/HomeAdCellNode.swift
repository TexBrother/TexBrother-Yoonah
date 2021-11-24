//
//  HomeAdCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/24.
//

import AsyncDisplayKit
import Then

final class HomeAdCellNode: ASCellNode {
    // MARK: - UI
    private var adImageNode = ASImageNode().then {
        $0.cornerRadius = 5
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
    }
    
    convenience init(image: String, size: CGSize) {
        self.init()
        adImageNode.image = UIImage(named: image)
        adImageNode.style.preferredSize = size
    }
    
    // MARK: - Node Life Cycle
    override func didLoad() {
        super.didLoad()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10),
            child: adImageNode
        )
    }
}
