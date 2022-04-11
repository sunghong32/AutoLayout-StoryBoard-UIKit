//
//  ViewController.swift
//  pomodoro
//
//  Created by 민성홍 on 2022/04/11.
//

import UIKit

enum TimerStatus {
    case start
    case pause
    case end
}

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var toggleButton: UIButton!

    var duration = 60
    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0

    func setTimerInfoViewVisible(isHidden: Bool) {
        self.timerLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }

    func configureToggleButton() {
        self.toggleButton.setTitle("시작", for: .normal)
        self.toggleButton.setTitle("일시정지", for: .selected)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }

    func startTimer() {
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: { [weak self] in
                self?.currentSeconds -= 1
                debugPrint(self?.currentSeconds ?? 0)

                if self?.currentSeconds ?? 0 <= 0 {
                    // 타이머가 종료
                    
                    self?.stopTimer()
                }
            })

            self.timer?.resume()
        }
    }

    func stopTimer() {
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        self.timerStatus = .end
        self.cancelButton.isEnabled = false
        self.setTimerInfoViewVisible(isHidden: true)
        self.datePicker.isHidden = false
        self.toggleButton.isSelected = false
        self.timer?.cancel()
        self.timer = nil
    }

    @IBAction func tapCancelButton(_ sender: UIButton) {
        switch timerStatus {
            case .start, .pause:
                self.stopTimer()

            default:
                break
        }
    }

    @IBAction func tapToggleButton(_ sender: UIButton) {
        self.duration = Int(self.datePicker.countDownDuration)

        switch timerStatus {
            case .start:
                self.timerStatus = .pause
                self.toggleButton.isSelected = false
                self.timer?.suspend()

            case .end:
                self.timerStatus = .start
                self.setTimerInfoViewVisible(isHidden: false)
                self.datePicker.isHidden = true
                self.toggleButton.isSelected = true
                self.cancelButton.isEnabled = true
                self.currentSeconds = self.duration
                self.startTimer()

            case .pause:
                self.timerStatus = .start
                self.toggleButton.isSelected = true
                self.timer?.resume()
        }
    }

}

