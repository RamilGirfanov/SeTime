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
        setupButton()
    }
    
    
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
        datePicker.tintColor = mainColorTheme
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()

    lazy var showButton: UIButton = {
        lazy var showButton = UIButton()
        showButton.setTitle("Показать", for: .normal)
        showButton.setTitleColor(.black, for: .normal)
        showButton.tintColor = .black
        showButton.backgroundColor = mainColorTheme
        showButton.layer.cornerRadius = totalCornerRadius
        showButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        showButton.translatesAutoresizingMaskIntoConstraints = false
        return showButton
    }()
        
    
//    MARK: - Layout
    
    private func layout() {
        [calendarLabel, datePicker, showButton].forEach { view.addSubview($0) }
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8

        NSLayoutConstraint.activate([
            calendarLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            calendarLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
                        
            datePicker.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: safeIndent2),
            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            datePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            showButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: safeIndent1),
            showButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            showButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            showButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects)
        ])
    }
}
