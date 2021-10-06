//
//  VoucherMenu.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/06.
//

import AsyncDisplayKit
import Then

final class VoucherMenu: ASDisplayNode {
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
    private let dividerNode = ASDisplayNode().then {
        $0.backgroundColor = .systemGray4.withAlphaComponent(0.3)
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 1)
            $0.width = ASDimension(unit: .points, value: UIScreen.main.bounds.size.width - 40)
        }
    }
    private var titleTextNode = ASTextNode()
    
    // MARK: - Initalizing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        self.styled {
            $0.height = ASDimension(unit: .points, value: 80)
        }
    }
    
    convenience init(_ image: String, title: String) {
        self.init()
        imageNode.image = UIImage(systemName: image)
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: Const.titleAttribute)
    }
    
    // MARK: Layout
    override func layout() {
        super.layout()
    }
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                centerLayoutSpec().styled {
                    $0.flexGrow = 1.0
                },
                dividerNode
            ]
        )
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
