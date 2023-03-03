import UIKit

final class ProfileAnimationView: UIView {
    
    private let originalImageView: UIImageView
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
    
    private lazy var widthConstraint: NSLayoutConstraint = avatarImageView.widthAnchor.constraint(equalToConstant: originalImageView.bounds.width)
    private lazy var heightConstraint: NSLayoutConstraint = avatarImageView.heightAnchor.constraint(equalToConstant: originalImageView.bounds.height)
    
    init(originalView: UIImageView) {
        originalImageView = originalView
        avatarImageView = originalView.cloneObject()!
        super.init(frame: UIScreen.main.bounds)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .black
        addSubview(avatarImageView)
        addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            widthConstraint, heightConstraint,
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func animateView() {
        avatarImageView.layer.cornerRadius = originalImageView.layer.cornerRadius
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            self.avatarImageView.layer.cornerRadius = 0
            self.widthConstraint.constant = min(self.bounds.width, self.bounds.height)
            self.heightConstraint.constant = self.widthConstraint.constant
            self.layoutIfNeeded()
            self.avatarImageView.center = self.center
            self.backgroundColor = .black.withAlphaComponent(0.6)
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
            self.avatarImageView.center = self.originalImageView.center
            self.avatarImageView.layer.cornerRadius = self.originalImageView.layer.cornerRadius
            self.backgroundColor = .black.withAlphaComponent(1.0)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 0
            }
            self.removeFromSuperview()
        })
    }
    
}
