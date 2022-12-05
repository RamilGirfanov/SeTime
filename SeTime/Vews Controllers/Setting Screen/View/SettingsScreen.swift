//
//  SettingsScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 03.12.2022.
//

import UIKit

protocol SetupsProtocol: AnyObject {
    func allowNotifications()
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
    
    private let workSwitchLabel: UILabel = {
        let workSwitchLabel = UILabel()
        workSwitchLabel.text = NSLocalizedString("notificationsAtWorkTime", comment: "")
        workSwitchLabel.font = .systemFont(ofSize: textSize2)
        workSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        return workSwitchLabel
    }()
    
    private var viewForWorkSwitch: UIView = {
        var viewForWorkSwitch = UIView()
        viewForWorkSwitch.backgroundColor = .secondarySystemBackground
        viewForWorkSwitch.layer.cornerRadius = totalCornerRadius
        viewForWorkSwitch.translatesAutoresizingMaskIntoConstraints = false
        return viewForWorkSwitch
    }()
    
    lazy var workSwitch: UISwitch = {
        var workSwitch = UISwitch()
        workSwitch.onTintColor = mainColorTheme
        workSwitch.translatesAutoresizingMaskIntoConstraints = false
        return workSwitch
    }()
    
    private let labelForWorkSwitch: UILabel = {
        let labelForWorkSwitch = UILabel()
        labelForWorkSwitch.text = NSLocalizedString("enableNotifications", comment: "")
        labelForWorkSwitch.font = .systemFont(ofSize: textSize2)
        labelForWorkSwitch.translatesAutoresizingMaskIntoConstraints = false
        return labelForWorkSwitch
    }()
    
    private let definitionWorkSwitch: UILabel = {
        let definitionWorkSwitch = UILabel()
        definitionWorkSwitch.text = NSLocalizedString("definitionWorkSwitch", comment: "")
        definitionWorkSwitch.numberOfLines = 0
        definitionWorkSwitch.font = .systemFont(ofSize: textSize4)
        definitionWorkSwitch.translatesAutoresizingMaskIntoConstraints = false
        return definitionWorkSwitch
    }()
    
    private let workTimeLabel: UILabel = {
        let workTimeLabel = UILabel()
        workTimeLabel.text = NSLocalizedString("timeToNotification", comment: "")
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
    
    private let definitionWorkTime: UILabel = {
        let definitionWorkTime = UILabel()
        definitionWorkTime.text = NSLocalizedString("timeBeforeBreak", comment: "")
        definitionWorkTime.numberOfLines = 0
        definitionWorkTime.font = .systemFont(ofSize: textSize4)
        definitionWorkTime.translatesAutoresizingMaskIntoConstraints = false
        return definitionWorkTime
    }()

    private let breakSwitchLabel: UILabel = {
        let screenLabel = UILabel()
        screenLabel.text = NSLocalizedString("notificationsAtBreakTime", comment: "")
        screenLabel.font = .systemFont(ofSize: textSize2)
        screenLabel.translatesAutoresizingMaskIntoConstraints = false
        return screenLabel
    }()
    
    private var viewForBreakSwitch: UIView = {
        var viewForBreakSwitch = UIView()
        viewForBreakSwitch.backgroundColor = .secondarySystemBackground
        viewForBreakSwitch.layer.cornerRadius = totalCornerRadius
        viewForBreakSwitch.translatesAutoresizingMaskIntoConstraints = false
        return viewForBreakSwitch
    }()
    
    lazy var breakSwitch: UISwitch = {
        var workSwitch = UISwitch()
        workSwitch.onTintColor = mainColorTheme
        workSwitch.translatesAutoresizingMaskIntoConstraints = false
        return workSwitch
    }()
    
    private let labelForBreakSwitch: UILabel = {
        let labelForWorkSwitch = UILabel()
        labelForWorkSwitch.text = NSLocalizedString("enableNotifications", comment: "")
        labelForWorkSwitch.font = .systemFont(ofSize: textSize2)
        labelForWorkSwitch.translatesAutoresizingMaskIntoConstraints = false
        return labelForWorkSwitch
    }()
    
    private let definitionBreakSwitch: UILabel = {
        let definitionBreakSwitch = UILabel()
        definitionBreakSwitch.text = NSLocalizedString("definitionBreakSwitch", comment: "")
        definitionBreakSwitch.numberOfLines = 0
        definitionBreakSwitch.font = .systemFont(ofSize: textSize4)
        definitionBreakSwitch.translatesAutoresizingMaskIntoConstraints = false
        return definitionBreakSwitch
    }()
    
    private let breakTimeLabel: UILabel = {
        let breakTimeLabel = UILabel()
        breakTimeLabel.text = NSLocalizedString("timeToNotification", comment: "")
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
    
    private let definitionBreakTime: UILabel = {
        let definitionBreakTime = UILabel()
        definitionBreakTime.text = NSLocalizedString("timeBeforeWork", comment: "")
        definitionBreakTime.numberOfLines = 0
        definitionBreakTime.font = .systemFont(ofSize: textSize4)
        definitionBreakTime.translatesAutoresizingMaskIntoConstraints = false
        return definitionBreakTime
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
        button.addTarget(self, action: #selector(allowNotifications), for: .touchUpInside)
        workSwitch.addTarget(self, action: #selector(workSwitchDidCanged), for: .valueChanged)
        breakSwitch.addTarget(self, action: #selector(breakSwitchDidCanged), for: .valueChanged)
    }
    
    @objc private func allowNotifications() {
        delegate?.allowNotifications()
    }
    
    @objc private func workSwitchDidCanged() {
        delegate?.changeWorkSwitch()
    }
    
    @objc private func breakSwitchDidCanged() {
        delegate?.changeBreakSwitch()
    }
    
    
//    MARK: - Настройка settingsScreen
    
    private func setupScreen() {
//        Настройка видимости кнопки разрешения уведомлений
        if UserDefaults.standard.bool(forKey: "notificationTolerance") == true {
            button.isHidden = true
        } else {
            button.isHidden = false
        }
        
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
        
        [screenLabel, workSwitchLabel, viewForWorkSwitch, definitionWorkSwitch, workTimeLabel, workDatePicker, definitionWorkTime, breakSwitchLabel, viewForBreakSwitch, definitionBreakSwitch, breakTimeLabel, breakDatePicker, definitionBreakTime, button].forEach { contentView.addSubview($0) }
        
                
        [labelForWorkSwitch, workSwitch].forEach { viewForWorkSwitch.addSubview($0) }
        [labelForBreakSwitch, breakSwitch].forEach { viewForBreakSwitch.addSubview($0) }
        
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

            workSwitchLabel.topAnchor.constraint(equalTo: screenLabel.bottomAnchor, constant: safeIndent1),
            workSwitchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            viewForWorkSwitch.topAnchor.constraint(equalTo: workSwitchLabel.bottomAnchor, constant: safeIndent2),
            viewForWorkSwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            viewForWorkSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            labelForWorkSwitch.centerYAnchor.constraint(equalTo: viewForWorkSwitch.centerYAnchor),
            labelForWorkSwitch.leadingAnchor.constraint(equalTo: viewForWorkSwitch.leadingAnchor, constant: safeIndent1),

            workSwitch.topAnchor.constraint(equalTo: viewForWorkSwitch.topAnchor, constant: safeIndent2),
            workSwitch.trailingAnchor.constraint(equalTo: viewForWorkSwitch.trailingAnchor, constant: -safeIndent1),
            workSwitch.bottomAnchor.constraint(equalTo: viewForWorkSwitch.bottomAnchor, constant: -safeIndent2),

            definitionWorkSwitch.topAnchor.constraint(equalTo: viewForWorkSwitch.bottomAnchor, constant: safeIndent2),
            definitionWorkSwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1 * 2),
            definitionWorkSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1 * 2),
            
            workTimeLabel.topAnchor.constraint(equalTo: definitionWorkSwitch.bottomAnchor, constant: safeIndent1),
            workTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            workDatePicker.topAnchor.constraint(equalTo: workTimeLabel.bottomAnchor, constant: safeIndent2),
            workDatePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            workDatePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            definitionWorkTime.topAnchor.constraint(equalTo: workDatePicker.bottomAnchor, constant: safeIndent2),
            definitionWorkTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1 * 2),
            definitionWorkTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1 * 2),
            
            breakSwitchLabel.topAnchor.constraint(equalTo: definitionWorkTime.bottomAnchor, constant: safeIndent1),
            breakSwitchLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            viewForBreakSwitch.topAnchor.constraint(equalTo: breakSwitchLabel.bottomAnchor, constant: safeIndent2),
            viewForBreakSwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            viewForBreakSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            labelForBreakSwitch.centerYAnchor.constraint(equalTo: viewForBreakSwitch.centerYAnchor),
            labelForBreakSwitch.leadingAnchor.constraint(equalTo: viewForBreakSwitch.leadingAnchor, constant: safeIndent1),
            
            breakSwitch.topAnchor.constraint(equalTo: viewForBreakSwitch.topAnchor, constant: safeIndent2),
            breakSwitch.trailingAnchor.constraint(equalTo: viewForBreakSwitch.trailingAnchor, constant: -safeIndent1),
            breakSwitch.bottomAnchor.constraint(equalTo: viewForBreakSwitch.bottomAnchor, constant: -safeIndent2),

            definitionBreakSwitch.topAnchor.constraint(equalTo: viewForBreakSwitch.bottomAnchor, constant: safeIndent2),
            definitionBreakSwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1 * 2),
            definitionBreakSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1 * 2),
            
            breakTimeLabel.topAnchor.constraint(equalTo: definitionBreakSwitch.bottomAnchor, constant: safeIndent1),
            breakTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            breakDatePicker.topAnchor.constraint(equalTo: definitionBreakSwitch.bottomAnchor, constant: safeIndent2),
            breakDatePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            breakDatePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            definitionBreakTime.topAnchor.constraint(equalTo: breakDatePicker.bottomAnchor, constant: safeIndent2),
            definitionBreakTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1 * 2),
            definitionBreakTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1 * 2),
            
            button.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            button.topAnchor.constraint(equalTo: definitionBreakTime.bottomAnchor, constant: safeIndent1),
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent1)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layout()
        setupTargrt()
        setupScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
