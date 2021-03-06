//
//  HomeNode.swift
//  AppStore-Example
//
//  Created by SHIN YOON AH on 2021/08/18.
//

import UIKit
import AsyncDisplayKit
import Then

final class HomeNode: ASDisplayNode {
    // MARK: UI
    private let bannerImageNode = ASImageNode().then {
        $0.image = UIImage(named: "appstoreBanner1")
    }
    private let infoTextNode = ASTextNode2().then {
        $0.attributedText = NSAttributedString(string: "고르고 골랐어요", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(red: 126/255, green: 144/255, blue: 163/255, alpha: 1.0), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    }
    private let recommendTextNode = ASTextNode2().then {
        $0.attributedText = NSAttributedString(string: "이번 주 추천 앱", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)])
    }
    private let updateTextNode = ASTextNode2().then {
        $0.attributedText = NSAttributedString(string: "새로 나온 앱과 업데이트를 모았습니다.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .medium)])
    }
    
    // MARK: Initializing
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    }
    
    // MARK: Node Life Cycle
    override func layout() {
        super.layout()
    }
    
    // MARK: Layout
    override func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
        return bannerLayoutSpec()
    }
    
    private func bannerImageLayoutSpec() -> ASLayoutSpec {
        return ASRatioLayoutSpec(ratio: 1.0, child: bannerImageNode).styled {
            $0.flexShrink = 1.0
        }
    }
    
    private func bannerTitleLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 7.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                infoTextNode,
                recommendTextNode
            ]
        )
    }
    
    private func bannerTitleInsetLayoutSpec() -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.left = 20.0
        containerInsets.top = 16.0
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: bannerTitleLayoutSpec()
        )
    }
    
    private func bannerBottomLayoutSpec() -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0.0,
            justifyContent: .start,
            alignItems: .start,
            children: [
                updateTextNode
            ]
        )
    }
    
    private func bannerBottomInsetLayoutSpec() -> ASLayoutSpec {
        var containerInsets: UIEdgeInsets = self.safeAreaInsets
        containerInsets.top = .infinity
        containerInsets.left = 20.0
        containerInsets.bottom = 15.0
        
        return ASInsetLayoutSpec(
            insets: containerInsets,
            child: bannerBottomLayoutSpec()
        )
    }

    private func bannerTopLayoutSpec() -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: bannerImageLayoutSpec(), overlay: bannerTitleInsetLayoutSpec()
        )
    }
    
    private func bannerLayoutSpec() -> ASLayoutSpec {
        return ASOverlayLayoutSpec(child: bannerTopLayoutSpec(), overlay: bannerBottomInsetLayoutSpec()
        )
    }
}

