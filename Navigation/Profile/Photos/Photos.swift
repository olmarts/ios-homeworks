//
//  Photos.swift
//  Navigation
//
//  Created by user1 on 22.02.2023.
//

import UIKit

class Photos {
    
    static func makeMockModel(maxCount: Int) -> [UIImage] {
        var array: [UIImage] = []
        for i in 0..<UInt16.max {
            if let image = UIImage(named: "\(i)") {
                array.append(image)
            }
            if i >= maxCount { break }
        }
        return array
    }
}
