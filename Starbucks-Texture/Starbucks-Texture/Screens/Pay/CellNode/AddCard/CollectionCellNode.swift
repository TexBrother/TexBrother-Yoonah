//
//  CollectionCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/03.
//

import AsyncDisplayKit
import Then

final class CollectionCellNode: ASCellNode {
    // MARK: - Section
    enum Section: Int, CaseIterable {
        case card
        case voucher
    }
    
    // MARK: - UI
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
        setupNotification()
        collectionNode.view.isScrollEnabled = false
    }
    
    // MARK: - Custom Method
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(onTapCard), name: NSNotification.Name("tapCard"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onTapVoucher), name: NSNotification.Name("tapVoucher"), object: nil)
    }
    
    @objc
    func onTapCard() {
        collectionNode.scrollToItem(at: IndexPath(item: 0, section: 0), at: .right, animated: true)
    }
    
    @objc
    func onTapVoucher() {
        collectionNode.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                collectionNode
            ]
        )
        
        var safeAreaInset: UIEdgeInsets = self.safeAreaInsets
        safeAreaInset.top = 10.0
        return ASInsetLayoutSpec (
            insets: safeAreaInset, child: stackLayout)
    }
}

// MARK: - ASCollectionDataSource
extension CollectionCellNode: ASCollectionDataSource {
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
