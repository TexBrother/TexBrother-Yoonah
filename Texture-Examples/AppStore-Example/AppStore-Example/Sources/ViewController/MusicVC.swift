//
//  MusicVC.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/25.
//

import AsyncDisplayKit
import Then

final class MusicVC: ASDKViewController<ASCollectionNode> {
    // MARK: - Properties
    let data: [Music] = [
        Music(title: "가습기", singer: "한요한", image: "musicAlbum1"),
        Music(title: "Thick and Thin", singer: "LANY", image: "musicAlbum2"),
        Music(title: "시공간", singer: "기리보이", image: "musicAlbum3"),
        Music(title: "NISEKOI", singer: "Futuristic Swaver", image: "musicAlbum4")
    ]
    
    // MARK: - Initalization
    override init() {
        let flowLayout = UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumInteritemSpacing = 5
            $0.minimumLineSpacing = 3
            $0.sectionInset = UIEdgeInsets(top: 72, left: 9, bottom: 0, right: 9)
            $0.headerReferenceSize = .zero
            $0.footerReferenceSize = .zero
        }
        super.init(node: ASCollectionNode(collectionViewLayout: flowLayout))
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.cellLayoutMode = .alwaysReloadData
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        node.delegate = self
        node.dataSource = self
        node.view.allowsSelection = false
        node.view.backgroundColor = .black
    }
}

extension MusicVC: ASCollectionDataSource {
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let musicModel = data[indexPath.row]

        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = MusicCellNode(title: musicModel.title, singer: musicModel.singer, image: musicModel.image)
            return cellNode
        }
        
        return cellNodeBlock
    }
}

extension MusicVC: ASCollectionDelegateFlowLayout {
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        var itemWidth: CGFloat = UIScreen.main.bounds.width
        itemWidth -= (9*2 + 5)
        itemWidth *= 0.5
        
        return ASSizeRange(min: .zero, max: .init(width: itemWidth, height: .infinity))
    }
}
