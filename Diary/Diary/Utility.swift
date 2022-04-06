//
//  Utility.swift
//  Diary
//
//  Created by 민성홍 on 2022/04/06.
//

import Foundation

struct Utility {
    static func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일 (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}
