//
//  HomeHeader.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/11/24.
//

import UIKit
import Then

class HomeHeader: UIView {

    // MARK: - UI
    private var cardButton = UIButton().then {
        $0.setTitle("What's New", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.setImage(UIImage(systemName: "envelope"), for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    var voucherButton = UIButton().then {
        $0.setTitle("Coupon", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.setImage(UIImage(systemName: "ticket"), for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    var bellButton = UIButton().then {
        $0.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.tintColor = .black
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(cardButton)
        addSubview(voucherButton)
        addSubview(bellButton)
    
        NSLayoutConstraint.activate([
            cardButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cardButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            cardButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            voucherButton.leadingAnchor.constraint(equalTo: cardButton.trailingAnchor, constant: 40),
            voucherButton.topAnchor.constraint(equalTo: self.cardButton.topAnchor),
            voucherButton.bottomAnchor.constraint(equalTo: self.cardButton.bottomAnchor),
            
            bellButton.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            bellButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            bellButton.widthAnchor.constraint(equalToConstant: 30),
            bellButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

}
