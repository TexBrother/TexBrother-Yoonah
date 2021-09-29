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
        
        static var nameAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 11.0, weight: .regular),
                    .foregroundColor: UIColor.systemGreen]
        }
    }
    
    private lazy var textfieldNode = ASEditableTextNode().then {
        $0.textContainerInset = .init(top: 5, left: 0, bottom: 5, right: 0)
        $0.scrollEnabled = false
        $0.borderWidth = 0.5
        $0.borderColor = UIColor.systemGray2.cgColor
        $0.delegate = self
    }
    private lazy var titleTextNode = ASTextNode().then {
        $0.isHidden = true
    }
    private lazy var infoNode = ASTextNode()
    
    init(_ placeholder: String, _ info: String, _ title: String) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        textfieldNode.attributedPlaceholderText = NSAttributedString(string: placeholder, attributes: Const.titleAttribute)
        infoNode.attributedText = NSAttributedString(string: info, attributes: Const.descriptionAttribute)
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: Const.nameAttribute)
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
                                            children: [titleTextNode,
                                                       textfieldNode,
                                                       infoNode])
        
        return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 15, left: 14, bottom: 16, right: 15),
                child: stackLayout
        )
    }
}

extension EditableTextField: ASEditableTextNodeDelegate {
    func editableTextNodeDidBeginEditing(_ editableTextNode: ASEditableTextNode) {
        print("hi")
        titleTextNode.isHidden = false
    }
    
    func editableTextNodeDidFinishEditing(_ editableTextNode: ASEditableTextNode) {
        print("bye")
        titleTextNode.isHidden = true
    }
}
