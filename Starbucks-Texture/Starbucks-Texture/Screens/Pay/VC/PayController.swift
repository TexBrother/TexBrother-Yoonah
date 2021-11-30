//
//  PayController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/21.
//

import AsyncDisplayKit
import Then

// MARK: - Protocol CardDelegate
protocol CardDelegate: PayController {
    func emptyCardClickedToPresent(_ viewController: AddCardController)
    func cardClickedToPresent(_ viewController: DetailCardController)
}

final class PayController: ASDKViewController<ASDisplayNode> {
    // MARK: - Section
    enum Section: Int, CaseIterable {
        case card
        case coupon
        case advertise
    }
    
    // MARK: - UI
    private lazy var tableNode = ASTableNode().then {
        $0.dataSource = self
        $0.backgroundColor = .white
    }
    private lazy var detailButton = UIButton().then {
        $0.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 17, weight: .regular, scale: .large), forImageIn: .normal)
        $0.tintColor = .lightGray
    }
    
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        tableNode.view.separatorStyle = .none
        tableNode.view.showsVerticalScrollIndicator = true
        detailButton.addTarget(self, action: #selector(touchUpCardList), for: .touchUpInside)
        setupNavigationController()
    }
    
    // MARK: - Custom Method
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layer.applyShadow(color: .gray, alpha: 0.3, x: 0, y: 0, blur: 12)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "Pay"
        
        let barButton = UIBarButtonItem(customView: detailButton)
        navigationItem.rightBarButtonItem = barButton
    }
    
    // MARK: - @objc
    @objc
    private func touchUpCardList() {
        let vc = CardListController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                tableNode.styled({
                    $0.flexGrow = 1.0
                })
            ]
        )
        let safeAreaInset: UIEdgeInsets = self.view.safeAreaInsets
        return ASInsetLayoutSpec (
            insets: safeAreaInset, child: contentLayout)
    }
}

// MARK: - ASTableDataSource
extension PayController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard let section = Section.init(rawValue: indexPath.row) else { return ASCellNode() }
            
            switch section {
            case .card:
                let cardCellNode = CardCellNode()
                cardCellNode.delegate = self
                return cardCellNode
            case .coupon:
                guard CardCellNode.cards.count > 0 else { return ASCellNode() }
                
                return CouponCellNode()
            case .advertise:
                return AdCellNode()
            }
        }
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        guard let section = Section.init(rawValue: indexPath.row) else { return ASSizeRange() }
        switch section {
        case .card:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 600))
        case .coupon:
            guard CardCellNode.cards.count > 0 else { return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 0)) }
            
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 70))
        case .advertise:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 70))
        }
    }

    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .white
    }
}

// MARK: - CardDelegate
extension PayController: CardDelegate {
    func cardClickedToPresent(_ viewController: DetailCardController) {
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func emptyCardClickedToPresent(_ viewController: AddCardController) {
        viewController.addCard = {
            CardCellNode.cards.append(contentsOf: [
                Card(cardImage: "thankyou", name: "Thank You 카드", balance: "2,300원", code: "****-****-**36-6582"),
                Card(cardImage: "limited", name: "Limited 카드", balance: "102,300원", code: "****-****-**70-7431")]
            )
            self.tableNode.reloadData()
        }
        viewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
