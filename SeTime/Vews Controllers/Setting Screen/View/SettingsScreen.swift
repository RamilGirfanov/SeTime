//
//  SettingsScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 03.12.2022.
//

import UIKit

protocol SetupsProtocol: AnyObject {
    func changeWorkSwitch()
    func changeBreakSwitch()
}

class SettingsScreen: UIView {
    
    //    MARK: - UIObjects
    
    private var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let screenLabel: UILabel = {
        let screenLabel = UILabel()
        screenLabel.text = NSLocalizedString("settings", comment: "")
        screenLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        screenLabel.translatesAutoresizingMaskIntoConstraints = false
        return screenLabel
    }()
    
    private let switchLabel: UILabel = {
        let switchLabel = UILabel()
        switchLabel.text = NSLocalizedString("enableNotifications", comment: "")
        switchLabel.font = .systemFont(ofSize: textSize2)
        switchLabel.translatesAutoresizingMaskIntoConstraints = false
        return switchLabel
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.layer.cornerRadius = totalCornerRadius
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var viewForWorkSwitch: UIView = {
        var viewForWorkSwitch = UIView()
        viewForWorkSwitch.backgroundColor = .secondarySystemBackground
        viewForWorkSwitch.translatesAutoresizingMaskIntoConstraints = false
        return viewForWorkSwitch
    }()
    
    lazy var workSwitch: UISwitch = {
        var workSwitch = UISwitch()
        workSwitch.onTintColor = mainColorTheme
        workSwitch.translatesAutoresizingMaskIntoConstraints = false
        return workSwitch
    }()
    
    private let textForWorkSwitch: UILabel = {
        let textForWorkSwitch = UILabel()
        textForWorkSwitch.text = NSLocalizedString("breakTimeNotifications", comment: "")
        textForWorkSwitch.font = .systemFont(ofSize: textSize2)
        textForWorkSwitch.translatesAutoresizingMaskIntoConstraints = false
        return textForWorkSwitch
    }()
    
    private var viewForBreakSwitch: UIView = {
        var viewForBreakSwitch = UIView()
        viewForBreakSwitch.backgroundColor = .secondarySystemBackground
        viewForBreakSwitch.translatesAutoresizingMaskIntoConstraints = false
        return viewForBreakSwitch
    }()
    
    lazy var breakSwitch: UISwitch = {
        var workSwitch = UISwitch()
        workSwitch.onTintColor = mainColorTheme
        workSwitch.translatesAutoresizingMaskIntoConstraints = false
        return workSwitch
    }()
    
    private let textForBreakSwitch: UILabel = {
        let textForBreakSwitch = UILabel()
        textForBreakSwitch.text = NSLocalizedString("workTimeNotifications", comment: "")
        textForBreakSwitch.font = .systemFont(ofSize: textSize2)
        textForBreakSwitch.translatesAutoresizingMaskIntoConstraints = false
        return textForBreakSwitch
    }()
    
    private let definitionSwitch: UILabel = {
        let definitionSwitch = UILabel()
        definitionSwitch.text = NSLocalizedString("definitionSwitch", comment: "")
        definitionSwitch.textColor = .secondaryLabel
        definitionSwitch.numberOfLines = 0
        definitionSwitch.font = .systemFont(ofSize: textSize4)
        definitionSwitch.translatesAutoresizingMaskIntoConstraints = false
        return definitionSwitch
    }()
    
    private let workTimeLabel: UILabel = {
        let workTimeLabel = UILabel()
        workTimeLabel.text = NSLocalizedString("timeToBreakTimeNotifications", comment: "")
        workTimeLabel.font = .systemFont(ofSize: textSize2)
        workTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeLabel
    }()
    
    var workDatePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let breakTimeLabel: UILabel = {
        let breakTimeLabel = UILabel()
        breakTimeLabel.text = NSLocalizedString("timeToWorkTimeNotifications", comment: "")
        breakTimeLabel.font = .systemFont(ofSize: textSize2)
        breakTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeLabel
    }()
    
    var breakDatePicker: UIDatePicker = {
        var breakDatePicker = UIDatePicker()
        breakDatePicker.datePickerMode = .countDownTimer
        breakDatePicker.translatesAutoresizingMaskIntoConstraints = false
        return breakDatePicker
    }()
    
    private var button: UIButton = {
        var button = UIButton()
        button.setTitle(NSLocalizedString("allowNotifications", comment: ""), for: .normal)
        button.activeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
//    MARK: - Delegade
    
    weak var delegate: SetupsProtocol?
    
    
//    MARK: - Настройка Target
    
    private func setupTargrt() {
        workSwitch.addTarget(self, action: #selector(workSwitchDidCanged), for: .valueChanged)
        breakSwitch.addTarget(self, action: #selector(breakSwitchDidCanged), for: .valueChanged)
    }
    
    @objc private func workSwitchDidCanged() {
        delegate?.changeWorkSwitch()
    }
    
    @objc private func breakSwitchDidCanged() {
        delegate?.changeBreakSwitch()
    }
    
    
//    MARK: - Настройка settingsScreen
    
    private func setupScreen() {
//        Настройка переключателей
        if UserDefaults.standard.bool(forKey: "notificationWorkTolerance") == true {
            workSwitch.isOn = true
        } else {
            workSwitch.isOn = false
        }
        
        if UserDefaults.standard.bool(forKey: "notificationBreakTolerance") == true {
            breakSwitch.isOn = true
        } else {
            breakSwitch.isOn = false
        }
    }

    
//    MARK: - Layout

    private func layout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [screenLabel, switchLabel, stack, definitionSwitch, workTimeLabel, workDatePicker, breakTimeLabel, breakDatePicker].forEach { contentView.addSubview($0) }
        
        [viewForWorkSwitch, viewForBreakSwitch].forEach { stack.addSubview($0) }
        [textForWorkSwitch, workSwitch].forEach { viewForWorkSwitch.addSubview($0) }
        [textForBreakSwitch, breakSwitch].forEach { viewForBreakSwitch.addSubview($0) }
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            screenLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeIndent1),
            screenLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),

            switchLabel.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: safeIndent1),
            switchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            stack.topAnchor.constraint(equalTo: switchLabel.bottomAnchor, constant: safeIndent2),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            viewForWorkSwitch.topAnchor.constraint(equalTo: stack.topAnchor),
            viewForWorkSwitch.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            viewForWorkSwitch.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            
            textForWorkSwitch.centerYAnchor.constraint(equalTo: viewForWorkSwitch.centerYAnchor),
            textForWorkSwitch.leadingAnchor.constraint(equalTo: viewForWorkSwitch.leadingAnchor, constant: safeIndent1),

            workSwitch.topAnchor.constraint(equalTo: viewForWorkSwitch.topAnchor, constant: safeIndent2),
            workSwitch.trailingAnchor.constraint(equalTo: viewForWorkSwitch.trailingAnchor, constant: -safeIndent1),
            workSwitch.bottomAnchor.constraint(equalTo: viewForWorkSwitch.bottomAnchor, constant: -safeIndent2),
            
            viewForBreakSwitch.topAnchor.constraint(equalTo: viewForWorkSwitch.bottomAnchor),
            viewForBreakSwitch.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            viewForBreakSwitch.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            viewForBreakSwitch.bottomAnchor.constraint(equalTo: stack.bottomAnchor),
            
            textForBreakSwitch.centerYAnchor.constraint(equalTo: viewForBreakSwitch.centerYAnchor),
            textForBreakSwitch.leadingAnchor.constraint(equalTo: viewForBreakSwitch.leadingAnchor, constant: safeIndent1),
            
            breakSwitch.topAnchor.constraint(equalTo: viewForBreakSwitch.topAnchor, constant: safeIndent2),
            breakSwitch.trailingAnchor.constraint(equalTo: viewForBreakSwitch.trailingAnchor, constant: -safeIndent1),
            breakSwitch.bottomAnchor.constraint(equalTo: viewForBreakSwitch.bottomAnchor, constant: -safeIndent2),
            
            definitionSwitch.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: safeIndent2),
            definitionSwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1 * 2),
            definitionSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1 * 2),
            
            workTimeLabel.topAnchor.constraint(equalTo: definitionSwitch.bottomAnchor, constant: safeIndent1),
            workTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            workDatePicker.topAnchor.constraint(equalTo: workTimeLabel.bottomAnchor, constant: safeIndent2),
            workDatePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            workDatePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            breakTimeLabel.topAnchor.constraint(equalTo: workDatePicker.bottomAnchor, constant: safeIndent1),
            breakTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            breakDatePicker.topAnchor.constraint(equalTo: breakTimeLabel.bottomAnchor, constant: safeIndent2),
            breakDatePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            breakDatePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            breakDatePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent1)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupScreen()
        setupTargrt()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
