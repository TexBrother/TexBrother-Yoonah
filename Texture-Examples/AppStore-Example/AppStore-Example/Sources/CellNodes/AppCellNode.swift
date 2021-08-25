//
//  AppCellNode.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/25.
//

import Foundation
import AsyncDisplayKit

class AppCellNode: ASCellNode {
    struct Const {
        static var descAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 11.0, weight: .regular),
                    .foregroundColor: UIColor.gray]
        }
        
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 13.0, weight: .medium),
                    .foregroundColor: UIColor.white]
        }
        
        static let insets: UIEdgeInsets =
            .init(top: 13.0, left: 18.0, bottom: 13.0, right: 13.0)
    }
    
    lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.cornerRadius = 10.0
        node.backgroundColor = .lightGray
        node.contentMode = .scaleAspectFit
        node.backgroundColor = .clear
        return node
    }()
    
    lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 2
        return node
    }()
    
    lazy var descriptionNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 2
        return node
    }()
    
    lazy var followButton: ASButtonNode = {
        let node = ASButtonNode()
        node.style.height = .init(unit: .points, value: 25.0)
        node.style.width = .init(unit: .points, value: 65.0)
        node.setImage(UIImage(named: "downloadBtn"), for: .normal)
        return node
    }()
    
    private var imageRatio: CGFloat = 0.5

    init(title: String, description: String, image: String) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
        self.backgroundColor = .black
        
        imageNode.image = UIImage(named: image)
        titleNode.attributedText = NSAttributedString(string: title, attributes: Const.titleAttribute)
        descriptionNode.attributedText = NSAttributedString(string: description, attributes: Const.descAttribute)
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 20.0,
                                            justifyContent: .start,
                                            alignItems: .stretch,
                                            children: [imageLayoutSpec(),
                                                       contentAreaLayoutSpec()])
        
        return ASInsetLayoutSpec(insets: Const.insets, child: stackLayout)
        
    }
    
    func imageLayoutSpec() -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: self.imageRatio, child: imageNode)
    }
    
    func contentAreaLayoutSpec() -> ASLayoutSpec {
        let infoAreaStackLayout = ASStackLayoutSpec(direction: .vertical,
                                                    spacing: 6.0,
                                                    justifyContent: .start,
                                                    alignItems: .start,
                                                    children: [titleNode, descriptionNode])
        
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 23.0,
                                 justifyContent: .start,
                                 alignItems: .start,
                                 children: [infoAreaStackLayout, followButton])
    }
}
