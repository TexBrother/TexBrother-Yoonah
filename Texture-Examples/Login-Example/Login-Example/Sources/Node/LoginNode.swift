//
//  LoginNode.swift
//  Login-Example
//
//  Created by SHIN YOON AH on 2021/08/11.
//

import UIKit
import AsyncDisplayKit
import Then

final class LoginNode: ASDisplayNode {
    // MARK: UI
    private let imageNode = ASImageNode().then {
        $0.image = UIImage(named: "logoImage")
        $0.contentMode = .scaleAspectFit
    }
    private let emailNode = ASEditableTextNode().then {
        $0.backgroundColor = .init(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)
        $0.attributedPlaceholderText = NSAttributedString(string: "이메일")
        $0.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    private let passwordNode = ASEditableTextNode().then {
        $0.backgroundColor = .init(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)
        $0.attributedPlaceholderText = NSAttributedString(string: "비밀번호")
        $0.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    private let autoButtonNode = ASButtonNode().then {
        $0.setTitle("자동 로그인", with: .systemFont(ofSize: 15), with: .white, for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        $0.tintColor = .systemPink
    }
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.left += 28.0
        containerInsets.right += 28.0
        containerInsets.top = containerInsets.bottom
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: contentLayoutSpec()
        )
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                imageLayoutSpec(),
                textFieldLayoutSpec()
            ]
        )
    }
    
    private func textFieldLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 36.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                emailNode,
                passwordNode,
                autoButtonLayoutSpec()
            ]
        )
    }
    
    private func autoButtonLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                autoButtonNode
            ]
        )
    }
    
    private func imageLayoutSpec() -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1.0, child: self.imageNode).styled {
            $0.flexShrink = 1.0
        }
    }
}
