//
//  VoucherDetailCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

final class VoucherDetailCellNode: ASCellNode {
    // MARK: - Const
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 17.0, weight: .bold),
                    .foregroundColor: UIColor.black]
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
            $0.height = ASDimension(unit: .points, value: 30)
        }
    }
    private let infoTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "모바일 카드 교환권을 등록하여 스타벅스 카드로 사용하세요.", attributes: Const.infoAttribute)
    }
    private let voucherInfoNode = ASDisplayNode().then {
        $0.backgroundColor = .systemGray4.withAlphaComponent(0.2)
    }
    private let voucherTitleTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "모바일 카드 교환권이란?", attributes: Const.titleAttribute)
    }
    private let voucherInfoTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "카카오톡 선물하기 등 타사에서 발행하는 모바일 상품권으로, 스타벅스 카드로 교환하여 사용하실 수 있습니다.\n\n교환권을 등록하면 상품권에 표시된 금액이 충전된 스타벅스 카드가 신규 발급됩니다.\n\n카드 교환권 등록 취소는 카드 미사용 시에 한하여 7일 이내에 가능합니다.", attributes: Const.infoAttribute)
    }
    private let voucherImageNode = VoucherMenu("photo", title: "교환권 이미지 불러오기")
    private let barcodeImageNode = VoucherMenu("barcode", title: "바코드 인식하기")
    private let numberImageNode = VoucherMenu("ellipsis.rectangle", title: "교환권 번호 입력하기")
    
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
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                contentInsetLayoutSpec(),
                voucherInfoOverlayLayoutSpec().styled {
                    $0.flexGrow = 1.0
                }
            ]
        )
    }
    
    private func infoInsetLayoutSpec() -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 7, left: 20, bottom: 5, right: 20),
            child: infoTextNode
        )
    }
    
    private func infoOverlayLayoutSpec() -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: infoNode, overlay: infoInsetLayoutSpec())
    }
    
    private func voucherInfoInsetLayoutSpec() -> ASLayoutSpec {
        let infoStackLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 20.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                voucherTitleTextNode,
                voucherInfoTextNode
            ]
        )
        
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20),
            child: infoStackLayout
        )
    }
    
    private func voucherInfoOverlayLayoutSpec() -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: voucherInfoNode, overlay: voucherInfoInsetLayoutSpec())
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        let voucherLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                voucherImageNode,
                barcodeImageNode,
                numberImageNode
            ]
        )
        
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 20.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                infoOverlayLayoutSpec(),
                voucherLayout
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
