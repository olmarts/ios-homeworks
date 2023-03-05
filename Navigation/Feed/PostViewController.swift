import UIKit

final class PostViewController: UIViewController {
    
    init(post: Post?) {
        super.init(nibName: nil, bundle: nil)
        title = post?.author
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        makeItemBar()
    }
    
    private func makeItemBar() {
        let barItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(barItemAction))
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc private func barItemAction() {
        present(InfoViewController(), animated: true)
    }
    
}

