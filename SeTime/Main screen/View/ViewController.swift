//
//  ViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.05.2022.
//

/// В этом файле:
/// - добавляются IBOutlet и IBAction
/// - производится частичная настройка внешнего вида экрана Main
/// - производится настройка UITableView
/// - в IBAction добавляются методы из расширения к ViewController
/// - создается делегат ячейки для управления в ней таймером

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupButtons()
        pushTaskScreen()
        makeBarButtonItem()
        navigationItem.largeTitleDisplayMode = .automatic
        
        self.setupToHideKeyboardOnTapOnView()
        
        checkDay()
    }
      
}
