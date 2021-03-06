//
//  CardDetailCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

final class CardDetailCellNode: ASCellNode {
    // MARK: - Const
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
        
        static var infoAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 13.0, weight: .regular),
                    .foregroundColor: UIColor.darkGray]
        }
    }
    
    // MARK: - UI
    private let infoNode = ASDisplayNode().then {
        $0.backgroundColor = .systemGray4.withAlphaComponent(0.2)
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 100)
        }
    }
    private let infoTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "스타벅스 카드 등록 시, 실물 카드와 카드 바코드 모두 사용 가능합니다.\n카드가 없다면 e-Gift Card의 나에게 선물하기를 이용해보세요. 카드명은 미입력 시 자동으로 부여됩니다.", attributes: Const.infoAttribute)
    }
    private let nameTextFieldNode = EditableTextField("카드명 최대 20자 (선택)", "카드명은 미입력 시 자동으로 부여됩니다.", "카드명", true)
    private let numberTextFieldNode = EditableTextField("스타벅스 카드번호 16자리 (필수)", "스타벅스 카드번호를 입력해 주세요.", "스타벅스 카드번호")
    private let pinTextFieldNode = EditableTextField("Pin번호 8자리 (필수)", "Pin번호를 입력해 주세요.", "Pin번호")
    
    // MARK: - Initalizing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
    }
    
    // MARK: - Node Life Cycle
    override func didLoad() {
        super.didLoad()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return contentInsetLayoutSpec()
    }
    
    private func infoInsetLayoutSpec() -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20),
            child: infoTextNode
        )
    }
    
    private func infoOverlayLayoutSpec() -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: infoNode, overlay: infoInsetLayoutSpec())
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
                pinTextFieldNode,
                infoOverlayLayoutSpec()
            ]
        )
    }
    
    private func contentInsetLayoutSpec() -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.top = 8.0
        containerInsets.left = 20.0
        containerInsets.right = 20.0
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: contentLayoutSpec()
        )
    }
}
