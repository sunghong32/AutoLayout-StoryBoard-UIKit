//
//  ViewController.swift
//  Calculator
//
//  Created by 민성홍 on 2022/03/28.
//

import UIKit

enum Operation {
    case add
    case subtract
    case divide
    case multiply
    case unknown
}

class ViewController: UIViewController {
    @IBOutlet weak var numberOutputLabel: UILabel!

    var displayNumber = ""
    var firstOperand = ""
    var secondOperand = ""
    var result = ""
    var currentOperation: Operation = .unknown

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapNumberButton(_ sender: UIButton) {
        guard let numberValue = sender.title(for: .normal) else { return }

        if self.displayNumber.count < 9 {
            self.displayNumber += numberValue
            self.numberOutputLabel.text = self.displayNumber
        }
    }

    @IBAction func clearButton(_ sender: UIButton) {
        self.displayNumber = ""
        self.firstOperand = ""
        self.secondOperand = ""
        self.result = ""
        self.currentOperation = .unknown
        self.numberOutputLabel.text = "0"
    }

    @IBAction func tapDotButton(_ sender: UIButton) {
        if self.displayNumber.count < 8, self.displayNumber.contains(".") == false {
            self.displayNumber += self.displayNumber.isEmpty ? "0." : "."
            self.numberOutputLabel.text = self.displayNumber
        }
    }

    @IBAction func tapDivideButton(_ sender: UIButton) {

    }

    @IBAction func tapMultiplyButton(_ sender: UIButton) {

    }

    @IBAction func tapSubtractButton(_ sender: UIButton) {

    }

    @IBAction func tapAddButton(_ sender: UIButton) {

    }

    @IBAction func tapEqulButton(_ sender: UIButton) {

    }
}

