//
//  MoreController.swift
//  KakaoTalk-Example
//
//  Created by SHIN YOON AH on 2021/08/31.
//

import AsyncDisplayKit
import Then

final class MoreController: ASDKViewController<ASDisplayNode> {
    private lazy var collectionNode = ASCollectionNode(collectionViewLayout: flowLayout).then {
        $0.dataSource = self
        $0.backgroundColor = .white
    }
    private var flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = 3
        $0.minimumLineSpacing = 19
        $0.sectionInset = UIEdgeInsets(top: 19, left: 19, bottom: 400, right: 19)
        $0.itemSize = CGSize(width: 70.0, height: 70.0)
        $0.headerReferenceSize = .zero
        $0.footerReferenceSize = .zero
    }
    
    private var headerNode = HeaderNode(title: "더보기")
    let sections: [String] = ["메일", "캘린더", "서랍", "카카오콘", "메이커스", "선물하기", "이모티콘", "프렌즈", "쇼핑하기", "스타일", "주문하기", "멜론티켓", "게임", "멜론", "헤어샵", "전체서비스"]
    
    override init() {
        super.init(node: .init())
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        
        self.node.onDidLoad({ [weak self] _ in
            self?.collectionNode.view.showsVerticalScrollIndicator = false
            self?.collectionNode.view.isScrollEnabled = false
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                headerNode,
                ProfileCellNode(model: Freind(imageName: "friendtabProfileImg", userName: "춘식이", statusMessage: "chunsik@kakao.com"), category: .freinds),
                collectionNode.styled({
                    $0.flexGrow = 1.0
                })
            ]
        )
        let safeAreaInset: UIEdgeInsets = self.view.safeAreaInsets
        return ASInsetLayoutSpec (
            insets: safeAreaInset, child: contentLayout)
    }
}

extension MoreController: ASCollectionDataSource {
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let data = sections[indexPath.row]

        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = MoreCellNode(title: data)
            return cellNode
        }
        
        return cellNodeBlock
    }
}
