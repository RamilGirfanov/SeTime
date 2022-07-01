//
//  DatePickerViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit

class DatePickerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
    
    
    //    MARK: - UIObjects

    private lazy var calendarLabel: UILabel = {
        lazy var timeTextLabel = UILabel()
        timeTextLabel.text = "Выбор даты"
        timeTextLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeTextLabel
    }()

    private lazy var datePicker: UIDatePicker = {
        lazy var datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.tintColor = mainColorTheme
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    private lazy var button: UIButton = {
        lazy var button = UIButton()
        button.setTitle("Показать", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.tintColor = .black
        button.backgroundColor = mainColorTheme
        button.layer.cornerRadius = totalCornerRadius
        button.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//    MARK: - Layout
    
    private func layout() {
        [calendarLabel, datePicker, button].forEach { view.addSubview($0) }
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8

        NSLayoutConstraint.activate([
            calendarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            calendarLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
                        
            datePicker.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: safeIndent2),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
//            ЗАДАТЬ ВЫСОТУ
            
            button.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: safeIndent1),
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            button.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects)
        ])
    }
}
