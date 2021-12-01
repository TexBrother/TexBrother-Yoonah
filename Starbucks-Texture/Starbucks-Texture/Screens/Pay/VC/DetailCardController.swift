//
//  DetailCardController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/13.
//

import AsyncDisplayKit
import Then
import RxSwift

final class DetailCardController: ASDKViewController<ASDisplayNode> {
    // MARK: - Const
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 28.0, weight: .semibold),
                    .foregroundColor: UIColor.black]
        }
        
        static var barcodeAttribute: [NSAttributedString.Key: Any] {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            return [.font: UIFont.systemFont(ofSize: 13.0, weight: .semibold),
                    .foregroundColor: UIColor.black, .paragraphStyle: paragraphStyle]
        }
        
        static var balanceTitleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 13.0, weight: .regular),
                    .foregroundColor: UIColor.black]
        }
        
        static var balanceAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 25.0, weight: .bold),
                    .foregroundColor: UIColor.black]
        }
        
        static var timeAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 12.0, weight: .semibold),
                    .foregroundColor: UIColor.seaweedGreen]
        }
    }
    
    // MARK: - Properties
    private var countdown = 600
    private let bag = DisposeBag()
    let lists: [String: String] = ["list.bullet.rectangle": "이용내역", "bolt.badge.a.fill": "자동 충전", "bolt.badge.a": "일반 충전", "arrow.left.arrow.right": "분실 신고 및 잔액 이전"]
    
    // MARK: - UI
    private lazy var tableNode = ASTableNode().then {
        $0.view.showsVerticalScrollIndicator = true
        $0.dataSource = self
        $0.backgroundColor = .systemGray4
    }
    private var cardImageNode = ASImageNode().then {
        $0.contentMode = .scaleAspectFit
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 80)
            $0.width = ASDimension(unit: .points, value: 150)
        }
    }
    private var barcodeImageNode = ASImageNode().then {
        $0.image = IconLiteral.imgBarcode
        $0.contentMode = .scaleAspectFit
        $0.styled {
            $0.height = ASDimension(unit: .points, value: 60)
            $0.width = ASDimension(unit: .points, value: 250)
        }
    }
    private var balanceTitleTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "카드 잔액", attributes: Const.balanceTitleAttribute)
    }
    private var codeTimeTitleTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "바코드 유효시간", attributes: Const.barcodeAttribute)
    }
    private var codeTimeTextNode = ASTextNode()
    private var titleTextNode = ASTextNode()
    private var balanceTextNode = ASTextNode()
    private var barcodeTextNode = ASTextNode()
    
    
    // MARK: - Initializing
    override init() {
        super.init(node: .init())
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
    }
    
    convenience init(index: Int) {
        self.init()
        
        titleTextNode.attributedText = NSAttributedString(string: CardCellNode.cards[index].name, attributes: Const.titleAttribute)
        cardImageNode.image = CardCellNode.cards[index].cardImage
        balanceTextNode.attributedText = NSAttributedString(string: CardCellNode.cards[index].balance, attributes: Const.balanceAttribute)
        barcodeTextNode.attributedText = NSAttributedString(string: CardCellNode.cards[index].code, attributes: Const.barcodeAttribute)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        bindAction()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Custom Method
    private func bindAction() {
        let observable = Observable<Int>
                        .interval(.seconds(1), scheduler: MainScheduler.instance)
                        .map { self.countdown - $0 }
                        .take(until: { $0 == 0 }, behavior: .inclusive)
        
        observable
            .subscribe(onNext: { [weak self] sec in
                guard let self = self else { return }
                
                let minute: Int = sec / 60
                let second: Int = sec % 60
                
                let minToString = (minute < 10) ? "0\(minute)" : "\(minute)"
                let secToString = (second < 10) ? "0\(second)" : "\(second)"
                
                self.codeTimeTextNode.attributedText = NSAttributedString(string: "\(minToString):\(secToString)", attributes: Const.timeAttribute)
            })
            .disposed(by: bag)
    }
    
    // MARK: - Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                contentLayoutSpec(),
                tableNode.styled({
                    $0.flexGrow = 1.0
                })
            ]
        )
        
        var containerInsets: UIEdgeInsets = self.view.safeAreaInsets
        containerInsets.bottom = -20.0
        return ASInsetLayoutSpec (
            insets: containerInsets, child: contentLayout)
    }
    
    private func cardLayoutSpec() -> ASLayoutSpec {
        let titleLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 3.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                balanceTitleTextNode,
                balanceTextNode
            ]
        )
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 8.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                cardImageNode,
                titleLayout
            ]
        )
    }
    
    private func barcodeLayoutSpec() -> ASLayoutSpec {
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
        let codeLayout = ASStackLayoutSpec(
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
        
        return ASCenterLayoutSpec(
            centeringOptions: .X,
            sizingOptions: [],
            child: codeLayout
        )
    }
    
    private func contentLayoutSpec() -> ASLayoutSpec {
        let topLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 50.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                titleTextNode,
                cardLayoutSpec()
            ]
        )
        let totalLayout = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 30.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                topLayout,
                barcodeLayoutSpec()
            ]
        )
        
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15), child: totalLayout)
    }
}

// MARK: - ASTableDataSource
extension DetailCardController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let index = Array(self.lists.keys)[indexPath.row]
            let cardCellNode = CardMenuCellNode(index, title: self.lists[index] ?? "")
            cardCellNode.backgroundColor = .systemGray4
            return cardCellNode
        }
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 70))
    }

    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .clear
    }
}

