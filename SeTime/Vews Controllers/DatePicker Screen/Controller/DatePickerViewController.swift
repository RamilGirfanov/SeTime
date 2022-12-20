//
//  DatePickerScreenVC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.06.2022.
//

import UIKit

class DatePickerScreenVC: UIViewController {
    
    //    MARK: - Экземпляр MainScreen
    
    lazy var datePickerScreen: DatePickerScreen = {
        let view = DatePickerScreen()
        view.delegate = self
        return view
    }()
    
    
    //    MARK: - Lifecycle
    
    override func loadView() {
        view = datePickerScreen
    }
}
