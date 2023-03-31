import UIKit

final class ProfileAnimationView: UIView {

    private let notification = NotificationCenter.default
    
    private let originalLayer: CALayer
    private let avatarImageView: UIImageView
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        button.backgroundColor = .white
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var widthConstraint: NSLayoutConstraint = avatarImageView.widthAnchor.constraint(equalToConstant: originalLayer.bounds.width)
    private lazy var heightConstraint: NSLayoutConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: originalLayer.bounds.height)
    
    init(originalView: UIImageView) {
        originalLayer = originalView.layer
        avatarImageView = originalView.cloneObject()!
        super.init(frame: UIScreen.main.bounds)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        avatarImageView.layer.cornerRadius = originalLayer.cornerRadius
        backgroundColor = .black
        addSubview(avatarImageView)
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            widthConstraint, heightConstraint,
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
        // при повороте экрана будем просто закрывать эту вью:
        notification.addObserver(
            self, selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification, object: nil
        )
    }
    
    func animateView() {
        bringSubviewToFront(avatarImageView)
       
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.avatarImageView.layer.cornerRadius = 0
            self.widthConstraint.constant = min(self.bounds.width, self.bounds.height)
            self.heightConstraint.constant = self.widthConstraint.constant
            self.layoutIfNeeded()
            self.avatarImageView.center = self.avatarImageView.centerInContainingWindow() 
            self.backgroundColor = .black.withAlphaComponent(0.6)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        }
    }
    
    @objc private func closeAction() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.widthConstraint.constant = self.originalLayer.bounds.width
            self.heightConstraint.constant = self.originalLayer.bounds.height
            self.layoutIfNeeded()
            self.avatarImageView.layer.position = self.originalLayer.position
            self.avatarImageView.layer.cornerRadius = self.originalLayer.cornerRadius
            self.backgroundColor = .black.withAlphaComponent(1.0)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 0
            }
            self.removeFromSuperview()
        })
    }
    
    @objc func orientationChanged(_ notification: NSNotification) {
        //print("\(UIDevice.current.orientation)", UIScreen.main.bounds.size)
        self.removeFromSuperview()
    }

    deinit {
        notification.removeObserver(UIDevice.orientationDidChangeNotification)
        self.removeFromSuperview()
    }
    
    
}

