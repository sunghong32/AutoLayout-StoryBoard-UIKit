//
//  RoundButton.swift
//  Calculator
//
//  Created by 민성홍 on 2022/03/29.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    @IBInspectable var isRound: Bool = false {
        didSet {
            if isRound {
                self.layer.cornerRadius = self.frame.height / 2
            }
        }
    }
}
