//
//  RecommendMenuCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/24.
//

import AsyncDisplayKit
import Then

final class RecommendMenuCellNode: ASCellNode {
    // MARK: - Const
    struct Const {
        static var titleAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 22.0, weight: .semibold),
                    .foregroundColor: UIColor.black]
        }
    }
    
    // MARK: - UI
    private var titleTextNode = ASTextNode().then {
        $0.attributedText = NSAttributedString(string: "윤아님을 위한 추천 메뉴", attributes: Const.titleAttribute)
    }
    private lazy var collectionNode = ASCollectionNode(collectionViewLayout: flowLayout).then {
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.showsHorizontalScrollIndicator = false
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width, height: 520)
    }
    private lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 20
        $0.sectionInset = .init(top: 20, left: 25, bottom: 0, right: 25)
        $0.itemSize = CGSize(width: 100, height: 150)
        $0.headerReferenceSize = .zero
        $0.footerReferenceSize = .zero
    }
    
    // MARK: - Properties
    static var cards: [Card] = []
    weak var delegate: CardDelegate?
    
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
    }
    
    // MARK: - Layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let titleLayout = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0),
            child: titleTextNode)
        let stackLayout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 5.0,
                                            justifyContent: .start,
                                            alignItems: .start,
                                            children: [titleLayout,
                                                       collectionNode])
        
        return ASInsetLayoutSpec (
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0),
            child: stackLayout
        )
    }
}

// MARK: - ASCollectionDataSource
extension RecommendMenuCellNode: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        guard CardCellNode.cards.count > 0 else { return 1 }
        
        return CardCellNode.cards.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            guard CardCellNode.cards.count > 0 else {
                let cellNode = DetailEmptyCellNode()
                cellNode.delegate = self.delegate
                return cellNode
            }
            
            let cellNode = DetailCardCellNode(card: CardCellNode.cards[indexPath.item], index: indexPath.row)
            cellNode.delegate = self.delegate
            return cellNode
        }
        
        return cellNodeBlock
    }
}

