//
//  CardListCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/13.
//

import UIKit

import AsyncDisplayKit
import Then

final class CardListCellNode: ASCellNode {
    // MARK: - Const
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 15.0, weight: .regular),
                    .foregroundColor: UIColor.black]
        }
        
        static var subTitleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 13.0, weight: .regular),
                    .foregroundColor: UIColor.gray]
        }
        
        static var balanceAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 25.0, weight: .bold),
                    .foregroundColor: UIColor.black]
        }
        
        static var subBalanceAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 21.0, weight: .bold),
                    .foregroundColor: UIColor.black]
        }
    }
    
    // MARK: - UI
    private lazy var cardImageNode = ASImageNode().then {
        $0.contentMode = .scaleAspectFit
        $0.styled {
            $0.height = ASDimension(unit: .points, value: isBasic ? 50 : 80)
            $0.width = ASDimension(unit: .points, value: isBasic ? 100 : 150)
        }
    }
    private let favoriteButtonNode = ASButtonNode().then {
        $0.setImage(IconLiteral.icFavorite, for: .normal)
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 40)
            $0.width = ASDimension(unit: .points, value: 40)
        }
    }
    private let titleTextNode = ASTextNode()
    private let balanceTextNode = ASTextNode()
    
    // MARK: - Properties
    private var isBasic = false
    
    // MARK: - Initalizing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
    }
    
    convenience init(isBasic: Bool = true,_ image: UIImage,_ title: String,_ balance: String) {
        self.init()
        self.isBasic = isBasic
        
        cardImageNode.image = image
        titleTextNode.attributedText = NSAttributedString(string: title, attributes: isBasic ?
                                                          Const.subTitleAttribute : Const.titleAttribute)
        balanceTextNode.attributedText = NSAttributedString(string: balance, attributes: isBasic ?
                                                            Const.subBalanceAttribute : Const.balanceAttribute)
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
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        let titleLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 5.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                titleTextNode,
                balanceTextNode
            ]
        )
        
        let cardLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 10.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                cardImageNode,
                titleLayout
            ]
        )
        
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 15.0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [
                cardLayout,
                favoriteButtonNode
            ]
        )
    }
    
    private func contentInsetLayoutSpec() -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.top = 20.0
        containerInsets.left = 15.0
        containerInsets.right = 15.0
        containerInsets.bottom = 20.0
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: contentLayoutSpec()
        )
    }
}
