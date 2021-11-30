//
//  AddCardController.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/09/29.
//

import AsyncDisplayKit
import Then

final class AddCardController: ASDKViewController<ASScrollNode> {
    
    // MARK: - UI
    private let rootScrollNode = ASScrollNode().then {
            $0.automaticallyManagesSubnodes = true
            $0.automaticallyManagesContentSize = true
            $0.automaticallyRelayoutOnSafeAreaChanges = true
            $0.backgroundColor = .blue
    }
    private lazy var tableNode = ASTableNode().then {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .white
        $0.view.separatorStyle = .none
        $0.view.showsVerticalScrollIndicator = true
        $0.view.estimatedSectionHeaderHeight = 100
    }
    private lazy var addButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 17, weight: .regular, scale: .large), forImageIn: .normal)
        $0.tintColor = .lightGray
    }
    
    // MARK: - Properties
    var addCard: (() -> ())?
    
    // MARK: - Initializing
    override init() {
        super.init(node: rootScrollNode)
        self.node.backgroundColor = .white
        self.node.automaticallyManagesSubnodes = true
        self.node.automaticallyRelayoutOnSafeAreaChanges = true
        self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
            return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
        }
        
        self.node.onDidLoad({ [weak self] _ in
            guard let self = self else { return }
            
            self.setupNavigationController()
            self.edgesForExtendedLayout = []
            self.addButton.addTarget(self, action: #selector(self.touchUpAddCard), for: .touchUpInside)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewWillDisappear(_ animated: Bool) {
        removeNotification()
    }

    // MARK: - Custom Method
    private func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "카드 추가"
        
        let barButton = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = barButton
    }
    
    
    private func removeNotification() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("tapCard"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("tapVoucher"), object: nil)
    }
    
    // MARK: - @objc
    @objc
    private func touchUpAddCard() {
        addCard?()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec (
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
    }
}

// MARK: - ASTableDataSource
extension AddCardController: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            return CollectionCellNode()
        }
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: self.view.frame.height))
    }

    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .white
    }
}

extension AddCardController: ASTableDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return AddCardHeader()
    }
}
