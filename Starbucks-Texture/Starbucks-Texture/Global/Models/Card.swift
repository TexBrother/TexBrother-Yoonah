//
//  Card.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/06.
//

import UIKit

struct Card {
    var cardImage: UIImage
    var name: String
    var balance: String
    var code: String
    
    init(cardImage: UIImage, name: String, balance: String, code: String) {
        self.cardImage = cardImage
        self.name = name
        self.balance = balance
        self.code = code
    }
    
    init() {
        self.cardImage = UIImage()
        self.name = ""
        self.balance = ""
        self.code = ""
    }
}
