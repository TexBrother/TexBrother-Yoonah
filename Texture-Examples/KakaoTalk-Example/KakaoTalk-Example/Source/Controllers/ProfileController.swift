//
//  ProfileController.swift
//  KakaoTalk-Example
//
//  Created by SHIN YOON AH on 2021/09/01.
//

import AsyncDisplayKit
import Then

final class ProfileController: ASDKViewController<ASDisplayNode> {    
    private var xmarkButtonNode = ASButtonNode().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .white
        $0.style.preferredSize = CGSize(width: 13, height: 14)
    }
    var profileImageNode = ASImageNode().then {
        $0.style.preferredSize = CGSize(width: 97, height: 96)
    }
    var nameTextNode = ASTextNode()
    
    override init() {
        super.init(node: .init())
        self.node.backgroundColor = .lightGray
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        
        xmarkButtonNode.addTarget(self, action: #selector(pressedXmark), forControlEvents: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func pressedXmark() {
        dismiss(animated: true, completion: nil)
    }
    
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 0.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [xmarkLayout().styled {
                                                $0.flexGrow = 1.0
                                            },
                                            profileLayout()])
    }
    
    func xmarkLayout() -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: .vertical,
                                 spacing: 0,
                                 justifyContent: .start,
                                 alignItems: .start,
                                 children: [xmarkButtonNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 58, left: 18, bottom: 0, right: 0), child: stackLayout)
    }
    
    func profileLayout() -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: .vertical,
                                 spacing: 8,
                                 justifyContent: .center,
                                 alignItems: .center,
                                 children: [profileImageNode,
                                            nameTextNode])
        
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 0.0,
                                 justifyContent: .start,
                                 alignItems: .stretch,
                                 children: [stackLayout,
                                            ProfileMenuNode()])
    }
}
