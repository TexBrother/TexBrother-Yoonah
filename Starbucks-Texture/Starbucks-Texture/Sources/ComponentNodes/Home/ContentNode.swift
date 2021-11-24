//
//  ContentNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/10.
//

import AsyncDisplayKit
import Then
import QuartzCore

private extension CGFloat {
    static let topHeight: CGFloat = 230
    static let scrollIdentity: CGFloat = 0
    static let scrollOffset: CGFloat = -47
}

final class ContentNode: ASDisplayNode {
    
    // MARK: - Section
    enum Section: Int, CaseIterable {
        case card
        case coupon
        case advertise
    }
    
    // MARK: - UI
    private lazy var tableNode = ASTableNode().then {
        $0.dataSource = self
        $0.delegate = self
        $0.view.separatorStyle = .none
        $0.view.showsVerticalScrollIndicator = true
        $0.backgroundColor = .white
    }
    private var topNode = TopView().then {
        $0.styled {
            $0.height = ASDimension(unit: .points, value: .topHeight)
        }
    }
    
    // MARK: - Properties
    
    private var didScroll: Bool = false
    private var scrollToTop: Bool = false
    private var ratio: CGFloat = 0.3
    
    // MARK: - Initalizing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    // MARK: - Override Method
    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        let beforeFrame = context.initialFrame(for: topNode)
        
        let afterFrame = context.finalFrame(for: topNode)
        topNode.frame = beforeFrame
        topNode.alpha = scrollToTop ? 1.0 : 0.0
        UIView.animate(withDuration: scrollToTop ? 0.0 : 0.2,
                       delay: 0.0,
                       options: .allowAnimatedContent,
                       animations: {
            self.topNode.frame = afterFrame
            self.topNode.alpha = self.scrollToTop ? 0.0 : 1.0
        }, completion: {
            context.completeTransition($0)
        })
    }
    
    // MARK: - Custom Method
    private func setRatio(_ ratio: CGFloat) {
        self.ratio = ratio
        self.transitionLayout(withAnimation: true,
                              shouldMeasureAsync: true,
                              measurementCompletion: nil)
    }
    
    // MARK: - Layout
    override func layout() {
        super.layout()
    }
    
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        topNode.style.flexBasis = .init(unit: .fraction, value: ratio)
        tableNode.style.flexBasis = .init(unit: .fraction, value: 1.0 - ratio)
        
        let contentLayout = ASStackLayoutSpec (
            direction: .vertical,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [
                topNode,
                tableNode
            ]
        )

        return contentLayout
    }
}

// MARK: - ASTableDataSource
extension ContentNode: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard let section = Section.init(rawValue: indexPath.row) else { return ASCellNode() }
            
            switch section {
            case .card:
                let cardCellNode = CardCellNode()
                return cardCellNode
            case .coupon:
                guard CardCellNode.cards.count > 0 else { return ASCellNode() }
                
                return CouponCellNode()
            case .advertise:
                return AdCellNode()
            }
        }
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        guard let section = Section.init(rawValue: indexPath.row) else { return ASSizeRange() }
        switch section {
        case .card:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 600))
        case .coupon:
            guard CardCellNode.cards.count > 0 else { return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 0)) }
            
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 70))
        case .advertise:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 70))
        }
    }

    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .white
    }
}

extension ContentNode: ASTableDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        // scroll up, when topView appear
        if offset > .scrollIdentity && !didScroll && !scrollToTop {
            didScroll = true
            scrollToTop = true
            UIView.animate(withDuration: 0.2,
                           delay: 0.0,
                           options: .curveLinear,
                           animations: {
                self.topNode.transform = CATransform3DTranslate(self.topNode.transform, 0, -.topHeight, 0)
            }, completion: { _ in
                self.setRatio(0.0)
            })
        }
        
        // scroll up, when topView disappear
        if offset == .scrollOffset && scrollToTop {
            didScroll = false
        }
        
        // scroll down, when topView appear
        if offset == .scrollIdentity && !scrollToTop {
            didScroll = false
        }
        
        // scorll down, when topView disappear
        if offset < .scrollOffset && !didScroll && scrollToTop {
            didScroll = true
            scrollToTop = false
            self.topNode.transform = CATransform3DTranslate(self.topNode.transform, 0, .topHeight, 0)
            self.tableNode.transform = CATransform3DTranslate(self.tableNode.transform, 0, .topHeight, 0)
            UIView.animate(withDuration: 0.0,
                           delay: 0.0,
                           options: .curveEaseOut,
                           animations: {
                self.setRatio(0.3)
                self.topNode.transform = CATransform3DTranslate(self.topNode.transform, 0, 0, 0)
                self.tableNode.transform = CATransform3DTranslate(self.tableNode.transform, 0, 0, 0)
            }, completion: nil)
        }
        
        print("didscroll: \(didScroll)")
        print("scrollToTop: \(scrollToTop)")
    }
}
