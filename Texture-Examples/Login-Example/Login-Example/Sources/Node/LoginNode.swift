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
        $0.textView.font = .systemFont(ofSize: 16)
        $0.textView.textColor = .white
        $0.textView.tintColor = .init(red: 234/255, green: 69/255, blue: 121/255, alpha: 1.0)
        $0.backgroundColor = .init(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)
        $0.attributedPlaceholderText = NSAttributedString(string: "이메일", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 22, bottom: 16, right: 22)
        $0.cornerRadius = 20
        $0.clipsToBounds = true
    }
    private let passwordNode = ASEditableTextNode().then {
        $0.textView.font = .systemFont(ofSize: 16)
        $0.textView.textColor = .white
        $0.textView.tintColor = .init(red: 234/255, green: 69/255, blue: 121/255, alpha: 1.0)
        $0.backgroundColor = .init(red: 47/255, green: 47/255, blue: 47/255, alpha: 1.0)
        $0.attributedPlaceholderText = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 22, bottom: 16, right: 22)
        $0.cornerRadius = 20
        $0.clipsToBounds = true
        $0.scrollEnabled = false
    }
    private let autoButtonNode = ASButtonNode().then {
        $0.setTitle("자동 로그인", with: .systemFont(ofSize: 15), with: .white, for: .normal)
        $0.setImage(UIImage(named: "checkboxInactive"), for: .normal)
        $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        $0.tintColor = .systemPink
    }
    private let loginButtonNode = ASButtonNode().then {
        $0.setTitle("로그인", with: .systemFont(ofSize: 16, weight: .medium), with: .white, for: .normal)
        $0.backgroundColor = .init(red: 234/255, green: 69/255, blue: 121/255, alpha: 1.0)
        $0.contentEdgeInsets = UIEdgeInsets(top: 17, left: 0, bottom: 17, right: 0)
        $0.cornerRadius = 25
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
        containerInsets.left = 0.0
        containerInsets.right = 0.0
        containerInsets.top = 135.0
        containerInsets.bottom = .infinity
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: contentLayoutSpec()
        )
    }
    
    private func imageRatioLayoutSpec() -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 0.5, child: self.imageNode).styled {
            $0.flexShrink = 0.5
        }
    }
    
    private func imageLayoutSpec() -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.left += 46.0
        containerInsets.right += 47.0
        containerInsets.top = 0
        containerInsets.bottom = 0
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: imageRatioLayoutSpec()
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
                autoButtonLayoutSpec(),
                loginButtonNode
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
    
    private func bottomLayoutSpecThatFits() -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.left += 28.0
        containerInsets.right += 28.0
        containerInsets.top = containerInsets.bottom
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: textFieldLayoutSpec()
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
                bottomLayoutSpecThatFits()
            ]
        )
    }
}
