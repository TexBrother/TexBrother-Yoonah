//
//  CoffeeCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/24.
//

import AsyncDisplayKit
import Then

final class CoffeeCellNode: ASCellNode {
    // MARK: - Const
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            return [.font: UIFont.systemFont(ofSize: 13.0, weight: .regular),
                    .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]
        }
    }
    
    // MARK: - UI
    private var imageNode = ASImageNode().then {
        $0.contentMode = .scaleAspectFill
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 130)
            $0.width = ASDimension(unit: .points, value: 130)
        }
    }
    private var textNode = ASTextNode().then {
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 40)
        }
    }
    
    // MARK: - Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
    }
    
    convenience init(title: String, image: UIImage) {
        self.init()
        textNode.attributedText = NSAttributedString(string: title, attributes: Const.titleAttribute)
        imageNode.image = image
    }
    
    // MARK: - Node Life Cycle
    override func didLoad() {
        super.didLoad()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 10.0,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [imageNode,
                                                       textNode])
        
        return stackLayout
    }
}

