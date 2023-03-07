import UIKit

extension UIView {
    
    static var identifier: String {
        String(describing: self)
    }
    
    func centerInContainingWindow() -> CGPoint {
        if let window = self.window, let superview = self.superview {
            let windowCenter = CGPoint(x: window.frame.midX, y: window.frame.midY)
            return superview.convert(windowCenter, from: nil)
        } else { return self.center }
    }
    
    func cloneObject<T:UIView>() -> T? {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject:self, requiringSecureCoding:false)
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? T
        }
        catch { fatalError("Error on \(#function).") }
    }
    
    func animateShakeEffect(_ duration: Double = 0.5) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = CFTimeInterval(floatLiteral: duration)
        animation.values = [-10.0, 10.0, -10.0, 10.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func animatePressEffect(duration: Double = 0.3) {
        UIView.animate(withDuration: duration, animations: {
            self.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }, completion: { _ in
            self.transform = .identity
        })
    }
}
