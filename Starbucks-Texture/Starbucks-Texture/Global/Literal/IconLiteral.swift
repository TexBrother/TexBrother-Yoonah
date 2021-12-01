//
//  IconLiteral.swift
//  Starbucks-Texture
//
//  Created by SHIN YOON AH on 2021/12/01.
//

import UIKit

public enum IconLiteral {

    // MARK: - Button
    
    public static var btnGiftSelected: UIImage { .load(name: "btn_giftSelected")}
    public static var btnGiftUnSelected: UIImage { .load(name: "btn_giftUnSelected") }
    public static var btnHomeSelected: UIImage { .load(name: "btn_homeSelected") }
    public static var btnHomeUnSelected: UIImage { .load(name: "btn_homeUnSelected") }
    public static var btnOrderSelected: UIImage { .load(name: "btn_orderSelected") }
    public static var btnOrderUnSelected: UIImage { .load(name: "btn_orderUnSelected") }
    public static var btnOtherSelected: UIImage { .load(name: "btn_otherSelected") }
    public static var btnOtherUnSelected: UIImage { .load(name: "btn_otherUnSelected") }
    public static var btnPaySelected: UIImage { .load(name: "btn_paySelected") }
    public static var btnPayUnSelected: UIImage { .load(name: "btn_payUnSelected") }
    
    // MARK: - Image
    
    public static var imgAdvertiseChristmas: UIImage { .load(name: "img_advertiseChristmas") }
    public static var imgAdvertiseHome: UIImage { .load(name: "img_advertiseHome") }
    public static var imgAdvertisePay: UIImage { .load(name: "img_advertisePay") }
    public static var imgBarcode: UIImage { .load(name: "img_barcode") }
    public static var imgCardLimited: UIImage { .load(name: "img_cardLimited") }
    public static var imgCardThankyou: UIImage { .load(name: "img_cardThankyou") }
    public static var imgAmericano: UIImage { .load(name: "img_americano") }
    public static var imgBanilla: UIImage { .load(name: "img_banilla") }
    public static var imgChocolate: UIImage { .load(name: "img_chocolate") }
    public static var imgColdbrew: UIImage { .load(name: "img_coldbrew") }
    public static var imgJamong: UIImage { .load(name: "img_jamong") }
    public static var imgJava: UIImage { .load(name: "img_java") }
    public static var imgLatte: UIImage { .load(name: "img_latte") }
    public static var imgPink: UIImage { .load(name: "img_pink") }
    public static var imgToffee: UIImage { .load(name: "img_toffee") }
    
    // MARK: - Icon
    
    public static var icAutoCharge: UIImage { .load(name: "ic_autoCharge") }
    public static var icFavorite: UIImage { .load(name: "ic_favorite") }
    public static var icNormalCharge: UIImage { .load(name: "ic_normalCharge") }
    
}

extension UIImage {
    fileprivate static func load(name: String) -> UIImage {
        guard let image = UIImage(named: name, in: nil, compatibleWith: nil) else {
            assert(false, "\(name) 이미지 로드 실패")
            return UIImage()
        }
        image.accessibilityIdentifier = name
        return image
    }
    
    internal func resize(to length: CGFloat) -> UIImage {
        let newSize = CGSize(width: length, height: length)
        let image = UIGraphicsImageRenderer(size: newSize).image { _ in
            draw(in: CGRect(origin: .zero, size: newSize))
        }
            
        return image
    }
}

