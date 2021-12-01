//
//  ContentNode.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/10.
//

import AsyncDisplayKit
import Then
import QuartzCore
import UIKit

private extension CGFloat {
    static let topHeight: CGFloat = 230
    static let buttonHeight: CGFloat = 30
    static let scrollIdentity: CGFloat = 0
    static let scrollOffset: CGFloat = -47
}

final class ContentNode: ASDisplayNode {
    
    // MARK: - Section
    enum Section: Int, CaseIterable {
        case adverties
        case recommend
        case banner
    }
    
    // MARK: - UI
    private lazy var tableNode = ASTableNode().then {
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = .white
        $0.view.separatorStyle = .none
        $0.view.showsVerticalScrollIndicator = true
        $0.view.estimatedSectionHeaderHeight = 100
    }
    private var topNode = TopView().then {
        $0.styled {
            $0.height = ASDimension(unit: .points, value: .topHeight)
        }
    }
    private var deliverButtonNode = ASButtonNode().then {
        $0.imageNode.image = UIImage(systemName: "bicycle")
        $0.backgroundColor = .seaweedGreen
        $0.cornerRadius = 30
    }
    private let statusbarView = UIView()
    private let header = HomeHeader()
    
    // MARK: - Properties
    
    private var didScroll: Bool = false
    private var scrollToTop: Bool = false
    private var ratio: CGFloat = 0.25
    private var scrollWidth: CGFloat = 0
    
    // MARK: - Initalizing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
        self.onDidLoad { [weak self] _ in
            self?.setupStatusBar(.clear)
        }
    }
    
    // MARK: - Override Method
    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        let beforeFrame = context.initialFrame(for: topNode)
        
        let afterFrame = context.finalFrame(for: topNode)
        topNode.frame = beforeFrame
        topNode.alpha = scrollToTop ? 1.0 : 0.0
        
        scrollWidth = scrollToTop ? 80.0 : 0.0
        deliverButtonNode.setTitle(scrollToTop ? "" : "Deliver", with: .boldSystemFont(ofSize: 20), with: .white, for: .normal)
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
        
        let insetLayout = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: UIScreen.main.bounds.size.height - 160, left: UIScreen.main.bounds.size.width - 80 - scrollWidth, bottom: 100, right: 20),
            child: deliverButtonNode)
        
        let overlayLayout = ASOverlayLayoutSpec(
            child: contentLayout,
            overlay: insetLayout)

        return overlayLayout
    }
    
    func setupStatusBar(_ color: UIColor) {
        if #available(iOS 13.0, *) {
            let margin = view.layoutMarginsGuide
            statusbarView.backgroundColor = color
            statusbarView.frame = CGRect.zero
            view.addSubview(statusbarView)
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                statusbarView.topAnchor.constraint(equalTo: view.topAnchor),
                statusbarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
                statusbarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                statusbarView.bottomAnchor.constraint(equalTo: margin.topAnchor)
            ])
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = color
        }
    }
}

// MARK: - ASTableDataSource
extension ContentNode: ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return Section.allCases.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard let section = Section.init(rawValue: indexPath.row) else { return ASCellNode() }
            
            switch section {
            case .adverties:
                return HomeAdCellNode(image: IconLiteral.imgAdvertiseHome, size: CGSize(width: UIScreen.main.bounds.size.width - 20, height: 250))
            case .recommend:
                return RecommendMenuCellNode()
            case .banner:
                return HomeAdCellNode(image: IconLiteral.imgAdvertiseChristmas, size: CGSize(width: UIScreen.main.bounds.size.width - 20, height: 500))
            }
        }
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        guard let section = Section.init(rawValue: indexPath.row) else { return ASSizeRange() }
        switch section {
        case .adverties:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width - 20, height: 250))
        case .recommend:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width, height: 250))
        case .banner:
            return ASSizeRange(min: .zero, max: .init(width: self.view.frame.width - 20, height: 500))
        }
    }

    func tableNode(_ tableNode: ASTableNode, willDisplayRowWith node: ASCellNode) {
        node.backgroundColor = .white
    }
}

extension ContentNode: ASTableDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
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
                self.statusbarView.backgroundColor = .white
                self.header.layer.applyShadow(color: UIColor.black, alpha: 0.2, x: 0, y: 5, blur: 3)
            })
        }
        
        // scroll up, when topView disappear
        if scrollToTop {
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
                self.setRatio(0.25)
                self.topNode.transform = CATransform3DTranslate(self.topNode.transform, 0, 0, 0)
                self.tableNode.transform = CATransform3DTranslate(self.tableNode.transform, 0, 0, 0)
                self.statusbarView.backgroundColor = .clear
                self.header.layer.applyShadow(color: UIColor.black, alpha: 0.0, x: 0, y: 0, blur: 0)
            }, completion: nil)
        }
        
        print("scrollOffset: \(offset)")
        print("scrollToTop: \(scrollToTop)")
        print("didScroll: \(didScroll)")
    }
}
