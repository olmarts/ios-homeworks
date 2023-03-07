import UIKit

extension UITextField {
    
    func setPlaceholderColor(_ color: UIColor?, alpha: Double = 0.6 ) {
        let color: UIColor = color ?? (self.textColor ?? .black)
        let alpha =  alpha < 1 ?  alpha : 1.0
        let attributeString = [
            NSAttributedString.Key.foregroundColor: color.withAlphaComponent(alpha),
            NSAttributedString.Key.font: self.font!
        ] as [NSAttributedString.Key : Any]
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: attributeString)
    }
    
}


extension UITextField {
    
    ///  Устанавливает кнопку показа/маскирования пароля.
    func enableEyeButton(_ enable: Bool, eyeColor: UIColor? = nil) {
        if enable == false {
            rightView = nil
        } else {
            let eyeButton: UIButton = {
                let button = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.size.height))
                button.setImage(getEyeImage(), for: .normal)
                button.tintColor = eyeColor ?? self.textColor
                button.addTarget(self, action: #selector(toggleShowPassword), for: .touchUpInside)
                return button
            }()
            rightView = eyeButton
            rightViewMode = .always
        }
    }
    
    fileprivate func getEyeImage() -> UIImage? {
        return isSecureTextEntry ? UIImage(systemName: "eye.slash.fill") : UIImage(systemName: "eye.fill")
    }
    
    @objc fileprivate func toggleShowPassword(sender: Any?) {
        self.isSecureTextEntry.toggle()
        if let button = sender as? UIButton {
            button.setImage(getEyeImage(), for: .normal)
            becomeFirstResponder()
        }
    }
}

