//
//  MoreCellNode.swift
//  KakaoTalk-Example
//
//  Created by SHIN YOON AH on 2021/08/31.
//

import AsyncDisplayKit

class MoreCellNode: ASCellNode {
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 11.0, weight: .regular),
                    .foregroundColor: UIColor.black]
        }
        
        static let insets: UIEdgeInsets =
            .init(top: 13.0, left: 18.0, bottom: 13.0, right: 13.0)
    }
    
    lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "messageTabIcon")
        node.style.preferredSize = CGSize(width: 20, height: 20)
        node.contentMode = .scaleAspectFit
        return node
    }()
    
    lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    init(title: String) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
        
        titleNode.attributedText = NSAttributedString(string: title, attributes: Const.titleAttribute)
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 19, left: 0, bottom: 0, right: 0),
            child: contentAreaLayoutSpec()
        )
    }
    
    func contentAreaLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical,
                                spacing: 3.0,
                                justifyContent: .start,
                                alignItems: .center,
                                children: [imageNode,
                                           titleNode])
    }
}
