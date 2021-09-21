//
//  PayController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/21.
//

import AsyncDisplayKit
import Then

final class PayController: ASDKViewController<ASDisplayNode> {
    private struct Const {
        static var nameAttribute: [NSAttributedString.Key: Any] {
            return [.font: UIFont.systemFont(ofSize: 18.0, weight: .regular),
                    .foregroundColor: UIColor.white]
        }
    }
    
    enum Section: Int, CaseIterable {
        case card
        case advertise
    }
    
    private lazy var tableNode = ASTableNode().then {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .white
    }
    
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

extension PayController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard let section = Section.init(rawValue: indexPath.row) else { return ASCellNode() }
            
            switch section {
            case .card:
                return CardCellNode()
            case .advertise:
                return AdCellNode()
            }
        }
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        guard let section = Section.init(rawValue: indexPath.section) else { return ASSizeRange() }
        switch section {
        case .card:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 100))
        case .advertise:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 70))
        }
    }

    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .white
    }
}

extension PayController: ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {

    }
}
