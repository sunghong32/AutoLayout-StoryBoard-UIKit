//
//  Feature.swift
//  AppStore
//
//  Created by 민성홍 on 2022/06/28.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
