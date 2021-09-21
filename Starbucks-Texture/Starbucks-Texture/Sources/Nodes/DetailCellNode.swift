//
//  DetailCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/22.
//

import AsyncDisplayKit

final class DetailCellNode: ASCellNode {
    // MARK: - Properties
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            return [.font: UIFont.systemFont(ofSize: 17.0, weight: .bold),
                    .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]
        }
        
        static var descriptionAttribute: [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            return [.font: UIFont.systemFont(ofSize: 13.0, weight: .regular),
                    .foregroundColor: UIColor.gray, .paragraphStyle: paragraphStyle]
        }
        
        static let insets: UIEdgeInsets =
            .init(top: 13.0, left: 18.0, bottom: 13.0, right: 13.0)
    }
    
    // MARK: - UI
    private lazy var backview = ASDisplayNode().then {
        $0.backgroundColor = .white
    }
    
    private lazy var addCardButtonNode = ASButtonNode().then {
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width - 100, height: 180)
        $0.tintColor = .lightGray
        $0.backgroundColor = .systemGray4.withAlphaComponent(0.4)
        $0.cornerRadius = 15
    }
    private lazy var titleTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "스타벅스 카드를 등록해보세요.", attributes: Const.titleAttribute)
    }
    private lazy var descriptionTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "매장과 사이렌오더에서 쉽게 편리하게\n사용할 수 있고, 별도 적립할 수 있습니다.", attributes: Const.descriptionAttribute)
    }
    
    init(name: String, balance: String) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
        self.shadowOffset = CGSize(width: 2, height: 2)
        self.shadowColor = UIColor.gray.cgColor
        self.shadowRadius = 7
        self.shadowOpacity = 0.4
        self.clipsToBounds = false
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return overlayLayoutSpec()
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        let topLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 30.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                addCardButtonNode,
                titleTextNode
            ]
        )
        
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                topLayout,
                descriptionTextNode
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
    
    private func overlayLayoutSpec() -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: backview, overlay: contentInsetLayoutSpec())
    }
}
