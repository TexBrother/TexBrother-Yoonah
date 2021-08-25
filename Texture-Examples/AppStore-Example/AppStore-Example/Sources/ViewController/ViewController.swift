//
//  ViewController.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/18.
//

import AsyncDisplayKit

final class ViewController: ASDKViewController<ASTableNode> {
    enum Section: Int, CaseIterable {
        case header
        case apps
    }
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.node.backgroundColor = .black
        self.node.view.allowsSelection = true
        self.node.view.separatorStyle = .none
        self.node.view.backgroundColor = .black
        self.node.dataSource = self
        self.node.delegate = self
//        self.node.allowsSelection = true
    }
}

extension ViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return Section.allCases.count
    }
    
    func tableNode(_ tableNode: ASTableNode,
                   numberOfRowsInSection section: Int) -> Int {
        guard let section = Section.init(rawValue: section) else { return 0 }
        
        switch section {
        case .header: return 1
        case .apps: return data.count
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard let section = Section.init(rawValue: indexPath.section) else { return ASCellNode() }
            
            switch section {
            case .header:
                let cellNode = HeaderCellNode()
                
                return cellNode
            case .apps:
                let appModel = self.data[indexPath.row]
                let cellNode = AppCellNode(title: appModel.title, description: appModel.description, image: appModel.image)
                
                return cellNode
            }
        }
    }
}

extension ViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = MusicVC()
            present(vc, animated: true, completion: nil)
        }
    }
}
