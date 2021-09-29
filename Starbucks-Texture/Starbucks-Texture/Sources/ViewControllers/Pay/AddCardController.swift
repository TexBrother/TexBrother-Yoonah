//
//  AddCardController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then
import TextureSwiftSupport

final class AddCardController: ASDKViewController<ASDisplayNode> {
    // MARK: - Properties
    enum Section: Int, CaseIterable {
        case header
        case addCard
    }
    
    // MARK: - UI
    private lazy var tableNode = ASTableNode().then {
        $0.dataSource = self
        $0.backgroundColor = .white
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
        
        self.node.onDidLoad({ [weak self] _ in
            self?.tableNode.view.separatorStyle = .none
            self?.tableNode.view.showsVerticalScrollIndicator = true
            self?.setupNavigationController()
            self?.setupTabbar()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Custom Method
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .darkGray
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "카드 추가"
    }
    
    private func setupTabbar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let tableLayout = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                tableNode.styled ({
                    $0.flexGrow = 1.0
                })
            ]
        )
        
        let safeAreaInset: UIEdgeInsets = self.view.safeAreaInsets
        return ASInsetLayoutSpec (
            insets: safeAreaInset, child: tableLayout)
    }
}

// MARK: - ASTableDataSource
extension AddCardController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard let section = Section.init(rawValue: indexPath.row) else { return ASCellNode() }
            
            switch section {
            case .header:
                return AddCardHeaderCellNode()
            case .addCard:
                return CardDetailCellNode()
            }
        }
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        guard let section = Section.init(rawValue: indexPath.row) else { return ASSizeRange() }
        switch section {
        case .header:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 50))
        case .addCard:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 600))
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .white
    }
}
