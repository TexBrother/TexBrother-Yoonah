//
//  TestCellNode.swift
//  Texture-Example
//
//  Created by SHIN YOON AH on 2021/08/11.
//

import AsyncDisplayKit
import Then

final class TestCellNode: ASCellNode {
    // MARK: UI
    private let imageNode = ASImageNode().then {
        $0.image = UIImage(named: "image")
        $0.borderColor = UIColor.gray.cgColor
        $0.borderWidth = 1.0
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleNode = ASTextNode().then {
        $0.maximumNumberOfLines = 2
    }
    
    // MARK: Initializing
    init(item: String) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.titleNode.attributedText = NSAttributedString(
            string: item,
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 15.0),
                .foregroundColor: UIColor.gray
            ]
        )
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
        self.imageNode.cornerRadius = 15.0
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0),
            child: self.contentLayoutSpec()
        )
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 10.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                self.imageLayoutSpec().styled {
                    $0.flexBasis =  ASDimension(unit: .fraction, value: 0.3)
                },
                self.titleNode.styled {
                    $0.flexBasis =  ASDimension(unit: .fraction, value: 0.7)
                }
            ]
        )
    }
    
    private func imageLayoutSpec() -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1.0, child: self.imageNode)
    }
}
