//
//  EditableTextField.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

final class EditableTextField: ASDisplayNode {
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 15.0, weight: .regular),
                    .foregroundColor: UIColor.black]
        }
        
        static var descriptionAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 11.0, weight: .regular),
                    .foregroundColor: UIColor.gray]
        }
    }
    
    private let textfieldNode = ASEditableTextNode().then {
        $0.scrollEnabled = false
        $0.borderWidth = 0.5
        $0.borderColor = UIColor.systemGray4.cgColor
    }
    private let infoNode = ASTextNode()
    
    init(_ placeholder: String, _ info: String) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        textfieldNode.attributedPlaceholderText = NSAttributedString(string: placeholder, attributes: Const.titleAttribute)
        infoNode.attributedText = NSAttributedString(string: info, attributes: Const.descriptionAttribute)
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 8.0,
                                            justifyContent: .start,
                                            alignItems: .stretch,
                                            children: [textfieldNode,
                                                       infoNode])
        
        return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 15, left: 14, bottom: 16, right: 15),
                child: stackLayout
        )
    }
}
