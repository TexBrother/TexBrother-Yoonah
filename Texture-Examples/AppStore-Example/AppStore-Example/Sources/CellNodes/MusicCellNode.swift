//
//  MusicCellNode.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/25.
//

import AsyncDisplayKit

class MusicCellNode: ASCellNode {
    struct Const {
        static var singerAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 10.0, weight: .regular),
                    .foregroundColor: UIColor.gray]
        }
        
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 11.0, weight: .regular),
                    .foregroundColor: UIColor.white]
        }
        
        static let insets: UIEdgeInsets =
            .init(top: 13.0, left: 18.0, bottom: 13.0, right: 13.0)
    }
    
    lazy var imageNode: ASImageNode = {
        let node = ASImageNode()
        node.cornerRadius = 5.0
        node.contentMode = .scaleAspectFit
        node.backgroundColor = .clear
        return node
    }()
    
    lazy var titleNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    lazy var singerNode: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 1
        return node
    }()
    
    private var imageRatio: CGFloat = 0.5
    
    init(title: String, singer: String, image: String) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
        self.backgroundColor = .black
        
        imageNode.image = UIImage(named: image)
        titleNode.attributedText = NSAttributedString(string: title, attributes: Const.titleAttribute)
        singerNode.attributedText = NSAttributedString(string: singer, attributes: Const.singerAttribute)
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 6, left: 6, bottom: 5, right: 6), child: contentAreaLayoutSpec())
    }
    
    func imageLayoutSpec() -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: self.imageRatio, child: imageNode)
    }
    
    func contentAreaLayoutSpec() -> ASLayoutSpec {
        let infoAreaStackLayout = ASStackLayoutSpec(direction: .vertical,
                                                    spacing: 4.0,
                                                    justifyContent: .start,
                                                    alignItems: .start,
                                                    children: [imageLayoutSpec(), titleNode])
        
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 3.0,
                                 justifyContent: .start,
                                 alignItems: .start,
                                 children: [infoAreaStackLayout, singerNode])
    }
}
