//
//  ViewController.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/18.
//

import AsyncDisplayKit

final class ViewController: ASDKViewController<ASTableNode> {
    // MARK: - Properties
    let tableNode = ASTableNode(style: .plain)
    
    let data: [Apps] = [
        Apps(title: "OUNCE - 집사를 위한 똑똑한 기록장", description: "우리 고양이의 까다로운 입맛 정리 서비스", image: "soptAppIcon1"),
        Apps(title: "포켓유니브", description: "MZ세대를 위한, 올인원 대학생활 관리 플랫폼", image: "soptAppIcon2"),
        Apps(title: "MOMO", description: "책 속의 문장과 함께 쓰는 일기", image: "soptAppIcon3"),
        Apps(title: "Weathy(웨디)", description: "나에게 돌아오는 맞춤 날씨 서비스", image: "soptAppIcon4"),
        Apps(title: "BeMe", description: "나를 알아가는 질문 다이어리", image: "soptAppIcon5"),
        Apps(title: "placepic", description: "우리들끼리 공유하는 최애장소, 플레이스픽", image: "soptAppIcon6"),
        Apps(title: "몽글(Mongle)", description: "우리가 만드는 문장 큐레이션 플랫폼, 몽글", image: "soptAppIcon7")
    ]
    
    // MARK: - Initalization
    override init() {
        super.init(node: tableNode)
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
//        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
//              return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.node.backgroundColor = .black
        self.node.view.allowsSelection = false
        self.node.view.separatorStyle = .none
        self.node.view.backgroundColor = .black
        self.node.dataSource = self
    }
    
    // MARK: Layout
//    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
//        let homeStackLayout = ASStackLayoutSpec(direction: .vertical,
//                                                spacing: 20,
//                                                justifyContent: .start,
//                                                alignItems: .start,
//                                                children: [
//                                                    MainNode()
//                                                ])
//
//        return ASInsetLayoutSpec(
//            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
//            child: homeStackLayout
//        )
//    }
}

extension ViewController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard data.count > indexPath.row else { return { ASCellNode() } }

        let appModel = data[indexPath.row]
        
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = AppCellNode(title: appModel.title, description: appModel.description, image: appModel.image)
            return cellNode
        }
        
        return cellNodeBlock
    }
}
