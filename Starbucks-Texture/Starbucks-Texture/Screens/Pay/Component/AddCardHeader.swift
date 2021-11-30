//
//  AddCardHeader.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/03.
//

import UIKit
import Then

class AddCardHeader: UIView {
    
    // MARK: - UI
    private var cardButton = UIButton().then {
        $0.setTitle("스타벅스 카드", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.addTarget(self, action: #selector(onTapCardTab), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    var voucherButton = UIButton().then {
        $0.setTitle("카드 교환권", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.addTarget(self, action: #selector(onTabVoucherTab), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    var bottomView = UIView().then {
        $0.backgroundColor = .seaweedGreen
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        self.layer.applyShadow(color: UIColor.black, alpha: 0.2, x: 0, y: 5, blur: 3)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(cardButton)
        addSubview(voucherButton)
        addSubview(bottomView)
    
        NSLayoutConstraint.activate([
            cardButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cardButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            cardButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            voucherButton.leadingAnchor.constraint(equalTo: cardButton.trailingAnchor, constant: 40),
            voucherButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            voucherButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            bottomView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            bottomView.widthAnchor.constraint(equalToConstant: 120),
            bottomView.heightAnchor.constraint(equalToConstant: 3)
        ])
    }
    
    // MARK: - @objc
    @objc
    func onTapCardTab() {
        moveIdentityDirection()
        NotificationCenter.default.post(name: NSNotification.Name("tapCard"), object: nil)
    }
    
    @objc
    func onTabVoucherTab() {
        moveVoucherDirection()
        NotificationCenter.default.post(name: NSNotification.Name("tapVoucher"), object: nil)
    }
}

// MARK: - Helper
extension AddCardHeader {
    func moveIdentityDirection() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomView.transform = .identity
        })
    }
    
    func moveVoucherDirection() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomView.transform = CGAffineTransform(translationX: self.bottomView.bounds.width, y: 0)
        })
    }
}
