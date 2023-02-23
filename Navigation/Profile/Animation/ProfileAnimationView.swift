import UIKit

final class ProfileAnimationView: UIView {
    
    // оригинальный аватар, так как потребуются его свойства:
    private let originalImageView: UIImageView
    
    // анимируемый аватар, чтобы не менять свойства оригинального аватара:
    private let userImageView: UIImageView
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var widthConstraint: NSLayoutConstraint = userImageView.widthAnchor.constraint(equalToConstant: originalImageView.bounds.width)
    private lazy var heightConstraint: NSLayoutConstraint = userImageView.heightAnchor.constraint(equalToConstant: originalImageView.bounds.height)
    
    init(originalView: UIImageView) {
        originalImageView = originalView
        userImageView = originalView.cloneObject()!
        super.init(frame: UIScreen.main.bounds)
        setup()
        // на весь экран (на главный UIWindow):
        self.addToWindow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .black
        addSubview(userImageView)
        addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            widthConstraint, heightConstraint,
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func animateView() {
        alpha = 1
        closeButton.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.widthConstraint.constant = self.bounds.width
            self.heightConstraint.constant = self.widthConstraint.constant
            self.layoutIfNeeded()
            self.userImageView.center = self.center
            self.userImageView.layer.cornerRadius = 0
            self.alpha = 0.7
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        }
    }
    
    @objc private func closeAction() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.widthConstraint.constant = self.originalImageView.bounds.width
            self.heightConstraint.constant = self.originalImageView.bounds.height
            self.layoutIfNeeded()
            self.userImageView.center = self.originalImageView.center
            self.userImageView.layer.cornerRadius = self.originalImageView.layer.cornerRadius
            self.alpha = 1
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 0
            }
            self.removeFromSuperview()
        })
    }
    
}
