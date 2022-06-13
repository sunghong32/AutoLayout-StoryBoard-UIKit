//
//  Content.swift
//  NetflixStyleSampleApp
//
//  Created by 민성홍 on 2022/06/13.
//

import UIKit

struct Content: Decodable {
    let sectionType: SectionType
    let sectionName: String
    let contentItem: [Item]

    enum SectionType: String, Decodable {
        case basic
        case main
        case large
        case rank
    }
}

struct Item: Decodable {
    let description: String
    let imageName: String

    var image: UIImage {
        get {
            return UIImage(named: imageName) ?? UIImage()
        }
    }
}
