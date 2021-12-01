//
//  RecommendMenuCellNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/24.
//

import AsyncDisplayKit
import Then
import UIKit

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
        $0.style.preferredSize = CGSize(width: UIScreen.main.bounds.size.width, height: 200)
    }
    private lazy var flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 0
        $0.minimumLineSpacing = 20
        $0.sectionInset = .init(top: 0, left: 25, bottom: 0, right: 25)
        $0.itemSize = CGSize(width: 130, height: 180)
        $0.headerReferenceSize = .zero
        $0.footerReferenceSize = .zero
    }
    
    // MARK: - Properties
    private var lists: [String: UIImage] = ["아이스 자몽 허니 블랙 티": IconLiteral.imgJamong, "초콜릿 크림 칩 프라푸치노": IconLiteral.imgChocolate, "아이스 핑크 캐모마일 릴렉서": IconLiteral.imgPink, "자바 칩 프라푸치노": IconLiteral.imgJava, "아이스 토피 넛 라떼": IconLiteral.imgLatte, "토피 넛 프라푸치노": IconLiteral.imgToffee, "아이스 카페 아메리카노": IconLiteral.imgAmericano, "토피 넛 콜드 브루": IconLiteral.imgColdbrew, "바닐라 크림 프라푸치노": IconLiteral.imgBanilla]
    
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
        return lists.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            let key = Array(self.lists.keys)[indexPath.row]
            guard let value = self.lists[key] else { return ASCellNode() }
            let cellNode = CoffeeCellNode(title: key, image: value)
            return cellNode
        }
        
        return cellNodeBlock
    }
}
