//
//  ExampleNode.swift
//  Texture-Example
//
//  Created by SHIN YOON AH on 2021/08/11.
//

import AsyncDisplayKit

class ExampleNode: ASDisplayNode {

    let buttonNode = ASButtonNode()
    let textNode = ASTextNode()
    let imageNode = ASImageNode()

    var isButtonNodeOnly: Bool = false
   

    override init() {
        super.init()
        // TODO: Background Thread에서 동작
        self.automaticallyManagesSubnodes = true
        self.addSubnode(imageNode)
    }
    
    override func didLoad() {
        super.didLoad()
        // TODO: Main Thread에서 접근 가능한 Property를 사용
        buttonNode.addTarget(self,
                             action: #selector(didTapButton),
                             forControlEvents: .touchUpInside)
    }
    
    override func layout() {
        super.layout()
        // TODO: layout변화에 따른 업데이트가 필요한 추가적인 요소를 처리합니다.
    }
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        // TODO: 순수하게 Texture에서 제공해주는 LayoutSpec 및 Layout Elements Properties 만 사용
        let imgLayout = ASInsetLayoutSpec(insets: .zero, child: imageNode)
        imgLayout.style.height = .init(unit: .points, value: 500.0)
        
        var elements: [ASLayoutElement] = [buttonNode]
        if !isButtonNodeOnly {
            elements.append(imageNode)
        }
        
        return ASAbsoluteLayoutSpec(children: elements)
    }
    
    @objc
    func didTapButton() {
       self.isButtonNodeOnly = !self.isButtonNodeOnly
       self.setNeedsLayout() // Layout을 다시 그려줘!
    }
}
