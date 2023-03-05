import UIKit

final class Photos {
    
    static func makeMockModel(maxCount: Int) -> [UIImage] {
        var array: [UIImage] = []
        for i in 1...maxCount {
            if let image = UIImage(named: "\(i)") {
                array.append(image)
            }
        }
        return array
    }
}
