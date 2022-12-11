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
    func updateTimeToNotice()
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
    
    private let switchStack: UIStackView = {
        let switchStack = UIStackView()
        switchStack.axis = .vertical
        switchStack.distribution = .fillEqually
        switchStack.layer.cornerRadius = totalCornerRadius
        switchStack.clipsToBounds = true
        switchStack.translatesAutoresizingMaskIntoConstraints = false
        return switchStack
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
    
    private let timeStack: UIStackView = {
        let timeStack = UIStackView()
        timeStack.axis = .vertical
        timeStack.distribution = .fillEqually
        timeStack.layer.cornerRadius = totalCornerRadius
        timeStack.clipsToBounds = true
        timeStack.translatesAutoresizingMaskIntoConstraints = false
        return timeStack
    }()

    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.text = NSLocalizedString("setupTime", comment: "")
        timeLabel.font = .systemFont(ofSize: textSize2)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()

    private let viewForWorkDatePicker: UIView = {
        let viewForWorkDatePicker = UIView()
        viewForWorkDatePicker.backgroundColor = .secondarySystemBackground
        viewForWorkDatePicker.translatesAutoresizingMaskIntoConstraints = false
        viewForWorkDatePicker.isUserInteractionEnabled = true
        return viewForWorkDatePicker
    }()
    
    private let workTimeLabel: UILabel = {
        let workTimeLabel = UILabel()
        workTimeLabel.text = NSLocalizedString("timeToBreakTimeNotifications", comment: "")
        workTimeLabel.font = .systemFont(ofSize: textSize2)
        workTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeLabel
    }()
    
    let workTimeDataLabel: UILabel = {
        let workTimeDataLabel = UILabel()
        workTimeDataLabel.font = .systemFont(ofSize: textSize2)
        workTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeDataLabel
    }()
    
    var workDatePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let viewForBreakDatePicker: UIView = {
        let viewForBreakDatePicker = UIView()
        viewForBreakDatePicker.backgroundColor = .secondarySystemBackground
        viewForBreakDatePicker.translatesAutoresizingMaskIntoConstraints = false
        viewForBreakDatePicker.isUserInteractionEnabled = true
        return viewForBreakDatePicker
    }()
    
    private let breakTimeLabel: UILabel = {
        let breakTimeLabel = UILabel()
        breakTimeLabel.text = NSLocalizedString("timeToWorkTimeNotifications", comment: "")
        breakTimeLabel.font = .systemFont(ofSize: textSize2)
        breakTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeLabel
    }()
    
    let breakTimeDataLabel: UILabel = {
        let breakTimeDataLabel = UILabel()
        breakTimeDataLabel.font = .systemFont(ofSize: textSize2)
        breakTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeDataLabel
    }()
    
    var breakDatePicker: UIDatePicker = {
        var breakDatePicker = UIDatePicker()
        breakDatePicker.datePickerMode = .countDownTimer
        breakDatePicker.translatesAutoresizingMaskIntoConstraints = false
        return breakDatePicker
    }()
        
    
//    MARK: - Delegade
    
    weak var delegate: SetupsProtocol?
    
    
//    MARK: - Настройка Target
    
    private func setupTargrt() {
        workSwitch.addTarget(self, action: #selector(workSwitchDidCanged), for: .valueChanged)
        breakSwitch.addTarget(self, action: #selector(breakSwitchDidCanged), for: .valueChanged)
        let tapWorkView = UITapGestureRecognizer(target: self, action: #selector(showWorkDatePicker))
        viewForWorkDatePicker.addGestureRecognizer(tapWorkView)
        
        let tapBreakView = UITapGestureRecognizer(target: self, action: #selector(showBreakDatePicker))
        viewForBreakDatePicker.addGestureRecognizer(tapBreakView)
    }
    
    @objc private func workSwitchDidCanged() {
        delegate?.changeWorkSwitch()
    }
    
    @objc private func breakSwitchDidCanged() {
        delegate?.changeBreakSwitch()
    }
    
    @objc private func showWorkDatePicker() {
        changeViewForWorkDatePicker()
    }
    
    @objc private func showBreakDatePicker() {
        changeViewForBreakDatePicker()
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
    
    private var heightWorkPicker = NSLayoutConstraint()
    private var heightBreakPicker = NSLayoutConstraint()

    private func layout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [screenLabel, switchLabel, switchStack, definitionSwitch, timeLabel, timeStack].forEach { contentView.addSubview($0) }
        
        [viewForWorkSwitch, viewForBreakSwitch].forEach { switchStack.addSubview($0) }
        [textForWorkSwitch, workSwitch].forEach { viewForWorkSwitch.addSubview($0) }
        [textForBreakSwitch, breakSwitch].forEach { viewForBreakSwitch.addSubview($0) }
        
        [viewForWorkDatePicker, viewForBreakDatePicker].forEach { timeStack.addSubview($0) }
        [workTimeLabel, workTimeDataLabel, workDatePicker].forEach { viewForWorkDatePicker.addSubview($0) }
        [breakTimeLabel, breakTimeDataLabel, breakDatePicker].forEach { viewForBreakDatePicker.addSubview($0) }

        heightWorkPicker = workDatePicker.heightAnchor.constraint(equalToConstant: 0)
        heightBreakPicker = breakDatePicker.heightAnchor.constraint(equalToConstant: 0)
        
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
            
            switchStack.topAnchor.constraint(equalTo: switchLabel.bottomAnchor, constant: safeIndent2),
            switchStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            switchStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            viewForWorkSwitch.topAnchor.constraint(equalTo: switchStack.topAnchor),
            viewForWorkSwitch.leadingAnchor.constraint(equalTo: switchStack.leadingAnchor),
            viewForWorkSwitch.trailingAnchor.constraint(equalTo: switchStack.trailingAnchor),
            
            textForWorkSwitch.centerYAnchor.constraint(equalTo: viewForWorkSwitch.centerYAnchor),
            textForWorkSwitch.leadingAnchor.constraint(equalTo: viewForWorkSwitch.leadingAnchor, constant: safeIndent1),

            workSwitch.topAnchor.constraint(equalTo: viewForWorkSwitch.topAnchor, constant: safeIndent2),
            workSwitch.trailingAnchor.constraint(equalTo: viewForWorkSwitch.trailingAnchor, constant: -safeIndent1),
            workSwitch.bottomAnchor.constraint(equalTo: viewForWorkSwitch.bottomAnchor, constant: -safeIndent2),
            
            viewForBreakSwitch.topAnchor.constraint(equalTo: viewForWorkSwitch.bottomAnchor),
            viewForBreakSwitch.leadingAnchor.constraint(equalTo: switchStack.leadingAnchor),
            viewForBreakSwitch.trailingAnchor.constraint(equalTo: switchStack.trailingAnchor),
            viewForBreakSwitch.bottomAnchor.constraint(equalTo: switchStack.bottomAnchor),
            
            textForBreakSwitch.centerYAnchor.constraint(equalTo: viewForBreakSwitch.centerYAnchor),
            textForBreakSwitch.leadingAnchor.constraint(equalTo: viewForBreakSwitch.leadingAnchor, constant: safeIndent1),
            
            breakSwitch.topAnchor.constraint(equalTo: viewForBreakSwitch.topAnchor, constant: safeIndent2),
            breakSwitch.trailingAnchor.constraint(equalTo: viewForBreakSwitch.trailingAnchor, constant: -safeIndent1),
            breakSwitch.bottomAnchor.constraint(equalTo: viewForBreakSwitch.bottomAnchor, constant: -safeIndent2),
            
            definitionSwitch.topAnchor.constraint(equalTo: switchStack.bottomAnchor, constant: safeIndent2),
            definitionSwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1 * 2),
            definitionSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1 * 2),
            
            
            
            
            timeLabel.topAnchor.constraint(equalTo: definitionSwitch.bottomAnchor, constant: safeIndent1),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            timeStack.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: safeIndent2),
            timeStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            timeStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            timeStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent1),
            
            viewForWorkDatePicker.topAnchor.constraint(equalTo: timeStack.topAnchor),
            viewForWorkDatePicker.leadingAnchor.constraint(equalTo: timeStack.leadingAnchor),
            viewForWorkDatePicker.trailingAnchor.constraint(equalTo: timeStack.trailingAnchor),
            
            workTimeLabel.topAnchor.constraint(equalTo: viewForWorkDatePicker.topAnchor, constant: 12),
            workTimeLabel.leadingAnchor.constraint(equalTo: viewForWorkDatePicker.leadingAnchor, constant: safeIndent1),
            
            workTimeDataLabel.centerYAnchor.constraint(equalTo: workTimeLabel.centerYAnchor),
            workTimeDataLabel.trailingAnchor.constraint(equalTo: viewForWorkDatePicker.trailingAnchor, constant: -safeIndent1),
            
            workDatePicker.topAnchor.constraint(equalTo: workTimeLabel.bottomAnchor),
            workDatePicker.centerXAnchor.constraint(equalTo: viewForWorkDatePicker.centerXAnchor),
            workDatePicker.bottomAnchor.constraint(equalTo: viewForWorkDatePicker.bottomAnchor, constant: -12),
            heightWorkPicker,
            
            viewForBreakDatePicker.topAnchor.constraint(equalTo: viewForWorkDatePicker.bottomAnchor),
            viewForBreakDatePicker.leadingAnchor.constraint(equalTo: timeStack.leadingAnchor),
            viewForBreakDatePicker.trailingAnchor.constraint(equalTo: timeStack.trailingAnchor),
            viewForBreakDatePicker.bottomAnchor.constraint(equalTo: timeStack.bottomAnchor),
            
            breakTimeLabel.topAnchor.constraint(equalTo: viewForBreakDatePicker.topAnchor, constant: 12),
            breakTimeLabel.leadingAnchor.constraint(equalTo: viewForBreakDatePicker.leadingAnchor, constant: safeIndent1),
            
            breakTimeDataLabel.centerYAnchor.constraint(equalTo: breakTimeLabel.centerYAnchor),
            breakTimeDataLabel.trailingAnchor.constraint(equalTo: viewForBreakDatePicker.trailingAnchor, constant: -safeIndent1),
            
            breakDatePicker.topAnchor.constraint(equalTo: breakTimeLabel.bottomAnchor),
            breakDatePicker.centerXAnchor.constraint(equalTo: viewForBreakDatePicker.centerXAnchor),
            breakDatePicker.bottomAnchor.constraint(equalTo: viewForBreakDatePicker.bottomAnchor, constant: -12),
            heightBreakPicker
        ])
    }
    
//    функции и свойства для изменения видимости datePicker
    private var workDatePickerShow = false
    private var breakDatePickerShow = false

    private func changeViewForWorkDatePicker() {
        if workDatePickerShow {
            heightWorkPicker.constant = 0
            layoutIfNeeded()
            delegate?.updateTimeToNotice()
            workDatePickerShow = false
        } else {
            heightWorkPicker.constant = 200
            layoutIfNeeded()
            workDatePickerShow = true
        }
    }
    
    private func changeViewForBreakDatePicker() {
        if breakDatePickerShow {
            heightBreakPicker.constant = 0
            layoutIfNeeded()
            delegate?.updateTimeToNotice()
            breakDatePickerShow = false
        } else {
            heightBreakPicker.constant = 200
            layoutIfNeeded()
            breakDatePickerShow = true
        }
    }
    
    
//    MARK: - init
    
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
