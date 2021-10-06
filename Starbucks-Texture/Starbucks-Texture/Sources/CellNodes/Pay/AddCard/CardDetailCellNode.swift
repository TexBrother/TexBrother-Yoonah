//
//  CardDetailCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

final class CardDetailCellNode: ASCellNode {
    // MARK: - Properties
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            return [.font: UIFont.systemFont(ofSize: 17.0, weight: .bold),
                    .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]
        }
        
        static var descriptionAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 11.0, weight: .regular),
                    .foregroundColor: UIColor.gray]
        }
    }
    
    // MARK: - UI
    private let nameTextFieldNode = EditableTextField("카드명 최대 20자 (선택)", "카드명은 미입력 시 자동으로 부여됩니다.", "카드명", true)
    private let numberTextFieldNode = EditableTextField("스타벅스 카드번호 16자리 (필수)", "스타벅스 카드번호를 입력해 주세요.", "스타벅스 카드번호")
    private let pinTextFieldNode = EditableTextField("Pin번호 8자리 (필수)", "Pin번호를 입력해 주세요.", "Pin번호")
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return contentInsetLayoutSpec()
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                nameTextFieldNode,
                numberTextFieldNode,
                pinTextFieldNode
            ]
        )
    }
    
    private func contentInsetLayoutSpec() -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.top = 20.0
        containerInsets.left = 20.0
        containerInsets.right = 20.0
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: contentLayoutSpec()
        )
    }
}
