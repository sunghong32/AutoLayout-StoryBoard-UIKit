//
//  ViewController.swift
//  pomodoro
//
//  Created by 민성홍 on 2022/04/11.
//

import UIKit
import AudioToolbox

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
    @IBOutlet weak var imageView: UIImageView!
    
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
                guard let self = self else { return }

                self.currentSeconds -= 1

                let hours = self.currentSeconds / 3600
                let minutes = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60

                self.timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)

                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration)

                UIView.animate(withDuration: 0.5, delay: 0, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
                })
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi * 2)
                })

                if self.currentSeconds <= 0 {
                    // 타이머가 종료
                    
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005)
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
        UIView.animate(withDuration: 0.5, animations: {
            self.timerLabel.alpha = 0
            self.progressView.alpha = 0
            self.datePicker.alpha = 1
            self.imageView.transform = .identity
        })
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
                UIView.animate(withDuration: 0.5, animations: {
                    self.timerLabel.alpha = 1
                    self.progressView.alpha = 1
                    self.datePicker.alpha = 0
                })
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

