//
//  RankingFeature.swift
//  AppStore
//
//  Created by 민성홍 on 2022/06/28.
//

import Foundation

struct RankingFeature: Decodable {
    let title: String
    let description: String
    let isInPurchaseApp: Bool
}
