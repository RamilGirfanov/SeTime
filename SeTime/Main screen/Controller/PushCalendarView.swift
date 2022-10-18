//
//  PushCalendarView.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit

extension ViewController {
    
    func makeBarButtonItem(){
        lazy var barButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(tap))
        
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc private func tap() {
        lazy var calendarVC = DatePickerViewController()
        calendarVC.title = "Выбор даты"
        present(calendarVC, animated: true)
    }
}

