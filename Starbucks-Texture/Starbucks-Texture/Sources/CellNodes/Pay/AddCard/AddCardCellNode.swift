//
//  AddCardCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

final class AddCardCellNode: ASCellNode {
    // MARK: - UI
    private lazy var collectionNode = ASCollectionNode(collectionViewLayout: flowLayout).then {
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width, height: 500)
        $0.isPagingEnabled = true
    }
    private var flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 0
        $0.sectionInset = .init(top: 0, left: 0, bottom:0, right: 0)
        $0.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 500)
        $0.headerReferenceSize = .zero
        $0.footerReferenceSize = .zero
    }
    
    var delegate: AddCardDelegate?
    
    // MARK: - Initalizing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.selectionStyle = .none
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            child: collectionNode
        )
    }
}

extension AddCardCellNode: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = DetailEmptyCellNode()
            cellNode.delegate = self.delegate
            return cellNode
        }
        
        return cellNodeBlock
    }
}
