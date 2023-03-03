import UIKit

extension UIView {
    
    static var identifier: String {
        String(describing: self)
    }
    
    func addToWindow()  {
        if let window = UIWindow.keyWindow() {
            self.frame = window.bounds
            window.addSubview(self)
        } else {
            fatalError("This UIApplication has'nt any UIWindow instances.")
        }
    }
    
    func cloneObject<T:UIView>() -> T? {
        do {
            // create an NSData object from self:
            let data = try NSKeyedArchiver.archivedData(withRootObject:self, requiringSecureCoding:false)
            // a clone by unarchiving the NSData:
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
        }
        catch { return nil }
    }
    
}


extension UIWindow {
    
    // MARK: - UIWindow.keyWindow()?.endEditing(true)
    static func keyWindow() -> UIWindow? {
        let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        return keyWindow
    }
    
}
