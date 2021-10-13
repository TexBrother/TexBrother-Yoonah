//
//  DetailCardCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/06.
//

import AsyncDisplayKit
import Then
import UIKit

final class DetailCardCellNode: ASCellNode {
    // MARK: - Properties
    struct Const {
        static var nameAttribute: [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            return [.font: UIFont.systemFont(ofSize: 13.0, weight: .semibold),
                    .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]
        }
        
        static var balanceAttribute: [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            return [.font: UIFont.systemFont(ofSize: 23.0, weight: .bold),
                    .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]
        }
        
        static var barcodeAttribute: [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .left
            
            return [.font: UIFont.systemFont(ofSize: 15.0, weight: .medium),
                    .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]
        }
        
        static var timeAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 12.0, weight: .medium),
                    .foregroundColor: UIColor.systemGreen]
        }
    }
    
    weak var delegate: CardDelegate?
    
    // MARK: - UI
    private var backview = ASDisplayNode().then {
        $0.backgroundColor = .white
        $0.cornerRadius = 15
        $0.shadowOffset = CGSize(width: 2, height: 2)
        $0.shadowColor = UIColor.gray.cgColor
        $0.shadowRadius = 7
        $0.shadowOpacity = 0.4
    }
    private var cardButtonNode = ASButtonNode().then {
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width - 100, height: 180)
        $0.backgroundColor = .systemGray4.withAlphaComponent(0.4)
        $0.cornerRadius = 8
        $0.clipsToBounds = true
    }
    private var barcodeImageNode = ASImageNode().then {
        $0.image = UIImage(named: "barcode")
        $0.contentMode = .scaleAspectFit
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 38)
            $0.width = ASDimension(unit: .points, value: 197)
        }
    }
    private var favoriteImageNode = ASImageNode().then {
        $0.image = UIImage(named: "favorite")
        $0.contentMode = .scaleAspectFit
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 21)
            $0.width = ASDimension(unit: .points, value: 21)
        }
    }
    private var codeTimeTitleTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "바코드 유효시간", attributes: Const.nameAttribute)
    }
    private var codeTimeTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "09:15", attributes: Const.nameAttribute)
    }
    private var nameTextNode = ASTextNode()
    private var balanceTextNode = ASTextNode()
    private var barcodeTextNode = ASTextNode()
    private var autoChargeButtonNode = ChargeButton("auto", title: "자동 충전")
    private var normalChargeButtonNode = ChargeButton("normal", title: "일반 충전")
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
        self.cornerRadius = 8
        self.clipsToBounds = false
    }
    
    convenience init(card: Card) {
        self.init()
        cardButtonNode.setImage(UIImage(named: card.cardImage), for: .normal)
        nameTextNode.attributedText = NSAttributedString(string: card.name, attributes: Const.nameAttribute)
        balanceTextNode.attributedText = NSAttributedString(string: card.balance, attributes: Const.balanceAttribute)
        barcodeTextNode.attributedText = NSAttributedString(string: card.code, attributes: Const.barcodeAttribute)
    }
    
    override func didLoad() {
        super.didLoad()
        cardButtonNode.addTarget(self, action: #selector(didTappedCardDetailButton), forControlEvents: .touchUpInside)
    }
    
    // MARK: - @objc
    @objc
    func didTappedCardDetailButton() {
        let vc = AddCardController()
        delegate?.cardClickedToPresent(vc)
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return overlayLayoutSpec()
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        let titleLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 3.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                nameTextNode,
                balanceTextNode
            ]
        )
        let favoriteLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 7.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                titleLayout,
                favoriteImageNode
            ]
        )
        let cardLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 26.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                cardButtonNode,
                favoriteLayout
            ]
        )
        let codeTimeLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 3.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                codeTimeTitleTextNode,
                codeTimeTextNode
            ]
        )
        let barcodeLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 6.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                barcodeImageNode,
                barcodeTextNode,
                codeTimeLayout
            ]
        )
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 13.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                cardLayout,
                barcodeLayout
            ]
        )
    }
    
    private func chargeContentLayoutSpec() -> ASLayoutSpec {
        let chargeLayout = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 79.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                autoChargeButtonNode,
                normalChargeButtonNode
            ]
        )
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 31.0,
            justifyContent: .start,
            alignItems: .center,
            children: [
                contentLayoutSpec(),
                chargeLayout
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
            child: chargeContentLayoutSpec()
        )
    }
    
    private func overlayLayoutSpec() -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: backview, overlay: contentInsetLayoutSpec())
    }
}
