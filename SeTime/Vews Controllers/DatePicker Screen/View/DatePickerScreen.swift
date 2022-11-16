//
//  DatePickerScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 01.11.2022.
//

import UIKit

protocol PresentHistory: AnyObject {
    func pushScreen()
}

class DatePickerScreen: UIView {

    
//    MARK: - UIObjects

    lazy var calendarLabel: UILabel = {
        lazy var timeTextLabel = UILabel()
        timeTextLabel.text = "Выбор даты"
        timeTextLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeTextLabel
    }()

    lazy var datePicker: UIDatePicker = {
        lazy var datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
//        datePicker.tintColor = mainColorTheme
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    lazy var showButton: UIButton = {
        lazy var showButton = UIButton()
        showButton.setTitle("Показать", for: .normal)
        showButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        showButton.roundYeellowButton()
        return showButton
    }()
        
    
//    MARK: - Delegate
    
    weak var delegate: PresentHistory?
    
//    MARK: - Layout
    
    private func layout() {
        [calendarLabel, datePicker, showButton].forEach { addSubview($0) }
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8

        NSLayoutConstraint.activate([
            calendarLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            calendarLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
                        
            datePicker.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: safeIndent2),
            datePicker.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            datePicker.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            showButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: safeIndent1),
            showButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            showButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            showButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects)
        ])
    }
    
    
//    MARK: - Настройка кнопок
    
    private func setupButtons() {
        showButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    @objc private func tap() {
        delegate?.pushScreen()
    }
    
    
//    MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layout()
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
