//
//  ASCellNode+.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/10/06.
//

import AsyncDisplayKit

extension ASCellNode {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ASCellNode.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
