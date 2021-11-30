//
//  ChargeButton.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/06.
//

import AsyncDisplayKit
import Then

final class ChargeButton: ASDisplayNode {
    // MARK: - Const
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 12.0, weight: .semibold),
                    .foregroundColor: UIColor.darkGray]
        }
    }
    
    // MARK: - UI
    private var buttonNode = ASButtonNode().then {
        $0.backgroundColor = .white
    }
    private var imageNode = ASImageNode().then {
        $0.contentMode = .scaleAspectFit
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 21)
            $0.width = ASDimension(unit: .points, value: 27)
        }
    }
    private var titleTextNode = ASTextNode()
    
    // MARK: - Initalizing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        self.styled {
            $0.height = ASDimension(unit: .points, value: 52)
            $0.width = ASDimension(unit: .points, value: 49)
        }
    }
    
    convenience init(_ image: String, title: String) {
        self.init()
        imageNode.image = UIImage(named: image)
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: Const.titleAttribute)
    }
    
    // MARK: - Layout
    override func layout() {
        super.layout()
    }
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: buttonNode, overlay: contentInsetLayoutSpec())
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 11.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                imageNode,
                titleTextNode
            ]
        )
    }
    
    private func contentInsetLayoutSpec() -> ASLayoutSpec {
        return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2),
                child: contentLayoutSpec()
        )
    }
}
