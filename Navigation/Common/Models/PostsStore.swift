import UIKit

final class PostsStore {
    
    static let shared: PostsStore = .init()
    private(set) var posts: [Post] = []
    static let postsDidSave: NSNotification.Name = NSNotification.Name("postsDidSave")
    
    private init() {
        guard let data = UserDefaults.standard.data(forKey: "posts") else {
            posts = Post.makeMockModel()
            save()
            return
        }
        do {
            posts = try JSONDecoder().decode([Post].self, from: data)
        }
        catch {
            print("Ошибка декодирования постов", error)
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(self.posts)
            UserDefaults.standard.setValue(data, forKey: "posts")
            NotificationCenter.default.post(name: PostsStore.postsDidSave, object: nil)
        }
        catch {
            print("Ошибка кодирования постов для сохранения", error)
        }
    }
}
