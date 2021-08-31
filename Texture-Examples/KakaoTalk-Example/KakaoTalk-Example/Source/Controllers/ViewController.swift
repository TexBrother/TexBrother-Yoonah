//
//  ViewController.swift
//  KakaoTalk-Example
//
//  Created by SHIN YOON AH on 2021/08/31.
//

import AsyncDisplayKit
import Then

final class ViewController: ASDKViewController<ASDisplayNode> {
    enum Section: Int, CaseIterable {
        case profile
        case freinds
    }
    
    private lazy var tableNode = ASTableNode().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .white
    }
    
    private var headerNode = HeaderNode()
    
    override init() {
        super.init(node: .init())
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        
        self.node.onDidLoad({ [weak self] _ in
            self?.tableNode.view.separatorStyle = .none
            self?.tableNode.view.showsVerticalScrollIndicator = false
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
                tableNode.styled({
                    $0.flexGrow = 1.0
                })
            ]
        )
        let safeAreaInset: UIEdgeInsets = self.view.safeAreaInsets
        return ASInsetLayoutSpec (
            insets: safeAreaInset, child: contentLayout)
    }
}

extension ViewController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return Section.allCases.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section.init(rawValue: section) else { return 0 }
        
        switch section {
        case .profile: return 1
        case .freinds: return 10
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard let section = Section.init(rawValue: indexPath.section) else { return ASCellNode() }
            
            switch section {
            case .profile:
                let myInfo = Freind(imageName: "friendtabProfileImg", userName: "한라봉이 먹고 싶은 춘식이", statusMessage: "Next Level yeah")
                return ProfileCellNode(model: myInfo, category: section)
            case .freinds:
                guard FreindsData.count > indexPath.row else { return ASCellNode() }
                let freindModel = FreindsData[indexPath.row]
                return ProfileCellNode(model: freindModel, category: section)
            }
        }
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        guard let section = Section.init(rawValue: indexPath.section) else { return ASSizeRange() }
        switch section {
        case .profile:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 100))
        case .freinds:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 70))
        }
    }

    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .white
    }
}

extension ViewController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        print("클릭 \(indexPath.row)")
    }
}
