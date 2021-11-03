//
//  AddCardController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

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
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 100)
    }
    private lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 0
        $0.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        $0.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 100)
        $0.headerReferenceSize = .zero
        $0.footerReferenceSize = .zero
    }
    private lazy var addButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 17, weight: .regular, scale: .large), forImageIn: .normal)
        $0.tintColor = .lightGray
    }
    private let headerNode = AddCardHeaderNode()
    
    // MARK: - Properties
    var addCard: (() -> ())?
    
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
            guard let self = self else { return }
            
            self.setupNavigationController()
            self.edgesForExtendedLayout = []
            self.addButton.addTarget(self, action: #selector(self.touchUpAddCard), for: .touchUpInside)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Method
    private func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "카드 추가"
        
        let barButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = barButton
    }
    
    // MARK: - @objc
    @objc
    private func touchUpAddCard() {
        addCard?()
        navigationController?.popViewController(animated: true)
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
    
    func collectionNode(_ collectionNode: ASCollectionNode, supplementaryElementKindsInSection section: Int) -> [String] {
        return [UICollectionView.elementKindSectionHeader]
    }
}
