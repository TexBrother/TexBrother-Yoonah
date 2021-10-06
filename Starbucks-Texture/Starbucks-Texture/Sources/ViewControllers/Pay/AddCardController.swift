//
//  AddCardController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then
import TextureSwiftSupport

final class AddCardController: ASDKViewController<ASScrollNode> {
    // MARK: - Section
    enum Section: Int, CaseIterable {
        case card
        case voucher
    }
    
    // MARK: - UI
    private let rootScrollNode = ASScrollNode().then {
            $0.automaticallyManagesSubnodes = true
            $0.automaticallyManagesContentSize = true
            $0.automaticallyRelayoutOnSafeAreaChanges = true
            $0.backgroundColor = .blue
    }
    private lazy var collectionNode = ASCollectionNode(collectionViewLayout: flowLayout).then {
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 200)
    }
    private lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 0
        $0.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        $0.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 200)
        $0.headerReferenceSize = .zero
        $0.footerReferenceSize = .zero
    }
    private let headerNode = AddCardHeaderNode()
    
    // MARK: - Initializing
    override init() {
        super.init(node: rootScrollNode)
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        
        self.node.onDidLoad({ [weak self] _ in
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
        return ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                headerNode,
                collectionNode
            ]
        )
    }
}

// MARK: - ASCollectionDataSource
extension AddCardController: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return Section.allCases.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let section = Section.init(rawValue: indexPath.row)
        
        let cellNodeBlock = { () -> ASCellNode in
            switch section {
            case .card:
                let cellNode = CardDetailCellNode()
                return cellNode
            case .voucher:
                let cellNode = VoucherDetailCellNode()
                return cellNode
            case .none:
                return ASCellNode()
            }
        }
        
        return cellNodeBlock
    }
}
