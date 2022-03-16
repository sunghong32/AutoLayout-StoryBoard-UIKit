//
//  CodePushViewController.swift
//  ScreenTransitionExample
//
//  Created by 민성홍 on 2022/03/16.
//

import UIKit

class CodePushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    @IBAction func tapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
