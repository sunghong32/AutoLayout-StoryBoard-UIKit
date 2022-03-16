//
//  SeguePresentViewController.swift
//  ScreenTransitionExample
//
//  Created by 민성홍 on 2022/03/16.
//

import UIKit

class SeguePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
