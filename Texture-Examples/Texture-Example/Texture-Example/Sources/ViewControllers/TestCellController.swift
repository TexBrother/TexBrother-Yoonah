//
//  TestCellController.swift
//  Texture-Example
//
//  Created by SHIN YOON AH on 2021/08/11.
//

import AsyncDisplayKit

final class TestCellController: ASDKViewController<ASTableNode> {
    // MARK: Properties
    var items: [String] = [
        "Welcome to Texture-KR",
        "Welcome to Texture-KR",
        "Welcome to Texture-KR, long test!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    ]
    
    // MARK: Initializing
    override init() {
        super.init(node: ASTableNode(style: .plain))
        self.node.backgroundColor = .white
        self.node.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -  ASTableDataSource
extension TestCellController: ASTableDataSource {
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let item = self.items[indexPath.row]
        return {
            return TestCellNode(item: item)
        }
    }
}
