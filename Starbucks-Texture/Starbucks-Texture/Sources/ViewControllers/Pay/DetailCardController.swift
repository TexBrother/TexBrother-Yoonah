//
//  DetailCardController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/13.
//

import AsyncDisplayKit
import Then

final class DetailCardController: ASDKViewController<ASDisplayNode> {
    
    // MARK: - UI
    private lazy var tableNode = ASTableNode().then {
        $0.view.showsVerticalScrollIndicator = true
        $0.dataSource = self
        $0.backgroundColor = .lightGray
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
    
    override func viewWillAppear(_ animated: Bool) {
        setupTabbar()
    }
    
    // MARK: - Custom Method
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "카드(\(CardCellNode.cards.count))"
        
        let barButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = barButton
    }
    
    private func setupTabbar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - @objc
    @objc
    private func touchUpAddCard() {
        let vc = AddCardController()
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
extension DetailCardController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            let card = CardCellNode.cards[0]
            let cardCellNode = CardListCellNode(isBasic: true,
                                                card.cardImage,
                                                card.name,
                                                card.balance)
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

