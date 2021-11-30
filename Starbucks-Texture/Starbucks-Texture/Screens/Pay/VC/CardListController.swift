//
//  CardListController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/13.
//

import AsyncDisplayKit
import Then

final class CardListController: ASDKViewController<ASDisplayNode> {
    // MARK: - Section
    enum Section: Int, CaseIterable {
        case advertise
        case favorite
        case basic
    }
    
    // MARK: - UI
    private lazy var tableNode = ASTableNode().then {
        $0.view.showsVerticalScrollIndicator = true
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .white
    }
    private lazy var addButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
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
        addButton.addTarget(self, action: #selector(touchUpAddCard), for: .touchUpInside)
        setupNavigationController()
    }
    
    // MARK: - Custom Method
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "카드(\(CardCellNode.cards.count))"
        
        let barButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = barButton
    }
    
    // MARK: - @objc
    @objc
    private func touchUpAddCard() {
        let vc = AddCardController()
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
extension CardListController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 3
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section.init(rawValue: section) else { return 0 }
        
        switch section {
        case .advertise:
            return 1
        case .favorite:
            guard CardCellNode.cards.count > 0 else { return 0 }
            return 1
        case .basic:
            guard CardCellNode.cards.count > 1 else { return 0 }
            return CardCellNode.cards.count - 1
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard let section = Section.init(rawValue: indexPath.section) else { return ASCellNode() }
            
            switch section {
            case .advertise:
                return AdCellNode()
            case .favorite:
                guard CardCellNode.cards.count > 0 else { return ASCellNode() }
                
                let card = CardCellNode.cards[0]
                let cardCellNode = CardListCellNode(isBasic: false,
                                                    card.cardImage,
                                                    card.name,
                                                    card.balance)
                return cardCellNode
            case .basic:
                guard CardCellNode.cards.count > 1 else { return ASCellNode() }
                
                let card = CardCellNode.cards[indexPath.row + 1]
                let cardCellNode = CardListCellNode(isBasic: true,
                                                    card.cardImage,
                                                    card.name,
                                                    card.balance)
                return cardCellNode
            }
        }
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        guard let section = Section.init(rawValue: indexPath.section) else { return ASSizeRange() }
        switch section {
        case .advertise:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 70))
        case .favorite:
            guard CardCellNode.cards.count > 0 else { return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 0)) }
            
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 120))
        case .basic:
            guard CardCellNode.cards.count > 1 else { return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 0)) }
            
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 90))
        }
    }

    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .white
    }
}

// MARK: - ASTableDelegate
extension CardListController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section.init(rawValue: indexPath.section) else { return }
        
        switch section {
        case .favorite:
            let vc = DetailCardController(index: indexPath.row)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        case .basic:
            let vc = DetailCardController(index: indexPath.row + 1)
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
