//
//  ViewController.swift
//  WordClockWidgets
//
//  Created by GitHub Copilot on 2026-04-04.
//

import UIKit

class ViewController: UIViewController {

    // UI Elements for configuration
    var previewContainer: UIView!
    var hourLabel: UILabel!
    var minuteLabel: UILabel!
    var dayNightLabel: UILabel!
    var dateLabel: UILabel!
    var dayOfWeekLabel: UILabel!

    var joystickUp: UIButton!
    var joystickDown: UIButton!
    var joystickLeft: UIButton!
    var joystickRight: UIButton!

    var saveButton: UIButton!
    var resetButton: UIButton!

    var backgroundColorButton: UIButton!
    var borderColorButton: UIButton!
    var backgroundAlphaSlider: UISlider!
    var borderWidthSlider: UISlider!
    var use12hSwitch: UISwitch!

    // Data
    var selectedBlock = "hour"
    var blockOffsets: [String: CGPoint] = [:]
    var currentBackgroundColor: UIColor = .white
    var currentBorderColor: UIColor = .black

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadOffsets()
        updatePreview()
    }

    func setupUI() {
        view.backgroundColor = .white

        // Preview Container
        previewContainer = UIView(frame: CGRect(x: 20, y: 100, width: 350, height: 150))
        previewContainer.backgroundColor = .lightGray
        previewContainer.layer.borderWidth = 1
        previewContainer.layer.borderColor = UIColor.black.cgColor
        view.addSubview(previewContainer)

        // Labels
        hourLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 100, height: 30))
        hourLabel.text = "Twelve"
        previewContainer.addSubview(hourLabel)

        minuteLabel = UILabel(frame: CGRect(x: 10, y: 50, width: 100, height: 30))
        minuteLabel.text = "Thirty"
        previewContainer.addSubview(minuteLabel)

        dayNightLabel = UILabel(frame: CGRect(x: 10, y: 90, width: 100, height: 30))
        dayNightLabel.text = "AM"
        previewContainer.addSubview(dayNightLabel)

        dateLabel = UILabel(frame: CGRect(x: 120, y: 10, width: 100, height: 30))
        dateLabel.text = "April 4"
        previewContainer.addSubview(dateLabel)

        dayOfWeekLabel = UILabel(frame: CGRect(x: 120, y: 50, width: 100, height: 30))
        dayOfWeekLabel.text = "Friday"
        previewContainer.addSubview(dayOfWeekLabel)

        // Joystick
        joystickUp = UIButton(frame: CGRect(x: 200, y: 200, width: 50, height: 50))
        joystickUp.setTitle("↑", for: .normal)
        joystickUp.addTarget(self, action: #selector(moveUp), for: .touchUpInside)
        view.addSubview(joystickUp)

        joystickDown = UIButton(frame: CGRect(x: 200, y: 300, width: 50, height: 50))
        joystickDown.setTitle("↓", for: .normal)
        joystickDown.addTarget(self, action: #selector(moveDown), for: .touchUpInside)
        view.addSubview(joystickDown)

        joystickLeft = UIButton(frame: CGRect(x: 150, y: 250, width: 50, height: 50))
        joystickLeft.setTitle("←", for: .normal)
        joystickLeft.addTarget(self, action: #selector(moveLeft), for: .touchUpInside)
        view.addSubview(joystickLeft)

        joystickRight = UIButton(frame: CGRect(x: 250, y: 250, width: 50, height: 50))
        joystickRight.setTitle("→", for: .normal)
        joystickRight.addTarget(self, action: #selector(moveRight), for: .touchUpInside)
        view.addSubview(joystickRight)

        // Buttons
        saveButton = UIButton(frame: CGRect(x: 20, y: 400, width: 100, height: 50))
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.addTarget(self, action: #selector(saveOffsets), for: .touchUpInside)
        view.addSubview(saveButton)

        resetButton = UIButton(frame: CGRect(x: 130, y: 400, width: 100, height: 50))
        resetButton.setTitle("Reset", for: .normal)
        resetButton.backgroundColor = .red
        resetButton.addTarget(self, action: #selector(resetAll), for: .touchUpInside)
        view.addSubview(resetButton)

        // Color and sliders
        backgroundColorButton = UIButton(frame: CGRect(x: 20, y: 470, width: 100, height: 50))
        backgroundColorButton.setTitle("BG Color", for: .normal)
        backgroundColorButton.backgroundColor = .gray
        view.addSubview(backgroundColorButton)

        borderColorButton = UIButton(frame: CGRect(x: 130, y: 470, width: 100, height: 50))
        borderColorButton.setTitle("Border Color", for: .normal)
        borderColorButton.backgroundColor = .gray
        view.addSubview(borderColorButton)

        backgroundAlphaSlider = UISlider(frame: CGRect(x: 20, y: 530, width: 200, height: 30))
        backgroundAlphaSlider.minimumValue = 0
        backgroundAlphaSlider.maximumValue = 1
        backgroundAlphaSlider.value = 1
        view.addSubview(backgroundAlphaSlider)

        borderWidthSlider = UISlider(frame: CGRect(x: 20, y: 570, width: 200, height: 30))
        borderWidthSlider.minimumValue = 0
        borderWidthSlider.maximumValue = 10
        borderWidthSlider.value = 1
        view.addSubview(borderWidthSlider)

        use12hSwitch = UISwitch(frame: CGRect(x: 20, y: 610, width: 50, height: 30))
        use12hSwitch.isOn = true
        view.addSubview(use12hSwitch)
    }

    @objc func moveUp() {
        moveBlock(dx: 0, dy: -5)
    }

    @objc func moveDown() {
        moveBlock(dx: 0, dy: 5)
    }

    @objc func moveLeft() {
        moveBlock(dx: -5, dy: 0)
    }

    @objc func moveRight() {
        moveBlock(dx: 5, dy: 0)
    }

    func moveBlock(dx: CGFloat, dy: CGFloat) {
        guard let label = getLabel(for: selectedBlock) else { return }
        label.frame.origin.x += dx
        label.frame.origin.y += dy
        blockOffsets[selectedBlock] = label.frame.origin
    }

    func getLabel(for block: String) -> UILabel? {
        switch block {
        case "hour": return hourLabel
        case "minute": return minuteLabel
        case "dayNight": return dayNightLabel
        case "date": return dateLabel
        case "dayOfWeek": return dayOfWeekLabel
        default: return nil
        }
    }

    @objc func saveOffsets() {
        // Save to UserDefaults or similar
        UserDefaults.standard.set(blockOffsets, forKey: "blockOffsets")
    }

    @objc func resetAll() {
        blockOffsets = [:]
        // Reset positions
        hourLabel.frame.origin = CGPoint(x: 10, y: 10)
        minuteLabel.frame.origin = CGPoint(x: 10, y: 50)
        dayNightLabel.frame.origin = CGPoint(x: 10, y: 90)
        dateLabel.frame.origin = CGPoint(x: 120, y: 10)
        dayOfWeekLabel.frame.origin = CGPoint(x: 120, y: 50)
    }

    func loadOffsets() {
        if let offsets = UserDefaults.standard.dictionary(forKey: "blockOffsets") as? [String: CGPoint] {
            blockOffsets = offsets
            // Apply positions
            if let pos = offsets["hour"] { hourLabel.frame.origin = pos }
            if let pos = offsets["minute"] { minuteLabel.frame.origin = pos }
            if let pos = offsets["dayNight"] { dayNightLabel.frame.origin = pos }
            if let pos = offsets["date"] { dateLabel.frame.origin = pos }
            if let pos = offsets["dayOfWeek"] { dayOfWeekLabel.frame.origin = pos }
        }
    }

    func updatePreview() {
        // Update time display
        let now = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: now)
        let minute = calendar.component(.minute, from: now)
        let day = calendar.component(.day, from: now)
        let month = calendar.component(.month, from: now)
        let year = calendar.component(.year, from: now)
        let weekday = calendar.component(.weekday, from: now)

        hourLabel.text = NumberToWords.convertHour(hour)
        minuteLabel.text = NumberToWords.convertMinute(minute)
        dayNightLabel.text = NumberToWords.getDayNight(hour)
        dateLabel.text = NumberToWords.convertDate(day, month, year)
        dayOfWeekLabel.text = NumberToWords.getDayOfWeek(weekday - 1)
    }
}