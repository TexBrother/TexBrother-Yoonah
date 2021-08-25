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
    var collectionNode = ASCollectionNode(collectionViewLayout: UICollectionViewLayout())
    let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 3
        $0.minimumLineSpacing = 5
    }
    
    let data: [Music] = [
        Music(title: "가습기", singer: "한요한", image: "musicAlbum1"),
        Music(title: "Thick and Thin", singer: "LANY", image: "musicAlbum2"),
        Music(title: "시공간", singer: "기리보이", image: "musicAlbum3"),
        Music(title: "NISEKOI", singer: "Futuristic Swaver", image: "musicAlbum4")
    ]
    
    // MARK: - Initalization
    override init() {
        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init(node: collectionNode)
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionNode.delegate = self
        collectionNode.dataSource = self
        collectionNode.view.allowsSelection = false
        collectionNode.view.backgroundColor = .black
    }
}

extension MusicVC: ASCollectionDataSource {
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

extension MusicVC: ASCollectionDelegate {
    
}
