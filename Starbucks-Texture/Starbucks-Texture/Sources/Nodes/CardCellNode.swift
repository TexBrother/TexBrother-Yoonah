//
//  CardCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/21.
//

import AsyncDisplayKit
import Then 

final class CardCellNode: ASCellNode {
    // MARK: - Properties
    let cards: [String] = []
    
    // MARK: - UI
    private lazy var collectionNode = ASCollectionNode(collectionViewLayout: flowLayout).then {
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width, height: 500)
    }
    private var flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 20
        $0.sectionInset = .init(top: 20, left: 25, bottom: 50, right: 25)
        $0.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 50, height: 430)
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

extension CardCellNode: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        guard cards.count > 0 else { return 1 }
        
        return cards.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = DetailCellNode(name: "골드", balance: "1,000")
            cellNode.delegate = self.delegate
            return cellNode
        }
        
        return cellNodeBlock
    }
}
