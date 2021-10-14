//
//  CardMenuCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/13.
//

import AsyncDisplayKit
import Then
import UIKit

final class CardMenuCellNode: ASCellNode {
    // MARK: - Const
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 15.0, weight: .semibold),
                    .foregroundColor: UIColor.black]
        }
    }
    
    // MARK: - UI
    private var imageNode = ASImageNode().then {
        $0.contentMode = .scaleAspectFit
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 21)
            $0.width = ASDimension(unit: .points, value: 27)
        }
    }
    private var navigateImageNode = ASImageNode().then {
        $0.image = UIImage(systemName: "chevron.right")
        $0.contentMode = .scaleAspectFit
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 20)
            $0.width = ASDimension(unit: .points, value: 20)
        }
    }
    private var titleTextNode = ASTextNode()
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
    }
    
    convenience init(_ image: String, title: String) {
        self.init()
        imageNode.image = UIImage(systemName: image)
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: Const.titleAttribute)
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let flexLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                centerLayoutSpec().styled {
                    $0.flexGrow = 1.0
                }
            ]
        )
        
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), child: flexLayout)
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        let titleLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 10.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                imageNode,
                titleTextNode
            ]
        )
        
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                titleLayout.styled{
                    $0.flexGrow = 1.0
                },
                navigateImageNode
            ]
        )
    }
    
    private func centerLayoutSpec() -> ASLayoutSpec {
        return ASCenterLayoutSpec(
            centeringOptions: .Y,
            sizingOptions: [],
            child: contentLayoutSpec()
        )
    }
}
