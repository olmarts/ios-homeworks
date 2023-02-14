//
//  Extensions.swift
//  Navigation
//
//  Created by user1 on 15.02.2023.
//

import UIKit


extension UITextField {
    
    // Устанавливает внутренние отступы текста для красоты.
    func setPadding(left: CGFloat, right: CGFloat? = nil) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: left, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        if let rightPadding = right {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: self.frame.size.height))
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    
    func placeholderColor(_ color: UIColor?, alpha: Double = 0.6 ) {
        let color: UIColor = color ?? (self.textColor ?? .black)
        let alpha =  alpha < 1 ?  alpha : 1.0
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(alpha),
            NSAttributedString.Key.font: self.font!
        ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
    
}


// let myColor = UIColor(hex: "#4F9BF5", alpha: 0.5)
extension UIColor {
    
    convenience init(hex:String, alpha:CGFloat = 1.0) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue: UInt64 = 10066329 //color #999999 if string has wrong format
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt64(&rgbValue)
        }
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
