//
//  EditableTextField.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

final class EditableTextField: ASDisplayNode {
    // MARK: - Const
    struct Const {
        static var placeholderAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 15.0, weight: .regular),
                    .foregroundColor: UIColor.black]
        }
        
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 11.0, weight: .regular),
                    .foregroundColor: UIColor.black]
        }
        
        static var descriptionAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 11.0, weight: .regular),
                    .foregroundColor: UIColor.gray]
        }
        
        static var errorAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 11.0, weight: .regular),
                    .foregroundColor: UIColor.systemRed]
        }
    }
    
    // MARK: - UI
    private lazy var textfieldNode = ASEditableTextNode().then {
        $0.textContainerInset = .init(top: 5, left: 0, bottom: 5, right: 0)
        $0.scrollEnabled = false
        $0.delegate = self
    }
    private lazy var titleTextNode = ASTextNode().then {
        $0.isHidden = true
    }
    private lazy var infoNode = ASTextNode()
    private var border = CALayer()
    
    // MARK: - Properties
    private var isShow = false
    private var info = ""
    
    // MARK: - Initalizing
    init(_ placeholder: String, _ info: String, _ title: String, _ isShow: Bool = false) {
        super.init()
        
        self.isShow = isShow
        self.info = info
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        
        textfieldNode.attributedPlaceholderText = NSAttributedString(string: placeholder, attributes: Const.placeholderAttribute)
        infoNode.attributedText = NSAttributedString(string: info, attributes: Const.descriptionAttribute)
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: Const.titleAttribute)
        infoNode.isHidden = !isShow
    }
    
    // MARK: - Node Life Cycle
    override func didLoad() {
        border.backgroundColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: 28, width: UIScreen.main.bounds.size.width - 40, height: 1)
        textfieldNode.layer.addSublayer(border)
        textfieldNode.layer.masksToBounds = false
        textfieldNode.textView.textContainer.maximumNumberOfLines = 1
        textfieldNode.textView.typingAttributes = Const.placeholderAttribute
    }
    
    // MARK: - Layout
    override func layout() {
        super.layout()
    }
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 8.0,
                                            justifyContent: .start,
                                            alignItems: .stretch,
                                            children: [titleTextNode,
                                                       textfieldNode,
                                                       infoNode])
        
        return stackLayout
    }
}

// MARK: - ASEditableTextNodeDelegate
extension EditableTextField: ASEditableTextNodeDelegate {
    func editableTextNodeDidBeginEditing(_ editableTextNode: ASEditableTextNode) {
        titleTextNode.isHidden = false
        border.backgroundColor = UIColor.systemGreen.cgColor
    }
    
    func editableTextNodeDidFinishEditing(_ editableTextNode: ASEditableTextNode) {
        if let text = editableTextNode.textView.text {
            if !text.isEmpty {
                border.backgroundColor = UIColor.lightGray.cgColor
                titleTextNode.isHidden = false
            } else {
                titleTextNode.isHidden = true
            }
        }
    }
    
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if !isShow {
            if text.isEmpty {
                infoNode.isHidden = false
                infoNode.attributedText = NSAttributedString(string: info, attributes: Const.errorAttribute)
                border.backgroundColor = UIColor.systemRed.cgColor
            } else {
                infoNode.isHidden = true
                border.backgroundColor = UIColor.systemGreen.cgColor
            }
        }
        
        return true
    }
}
