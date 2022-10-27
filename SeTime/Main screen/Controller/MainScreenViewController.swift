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

class MainScreenViewController: UIViewController {

    private lazy var mainScreen: MainScreen = {
       let view = MainScreen()
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pushTaskScreen()
        makeBarButtonItem()
        navigationItem.largeTitleDisplayMode = .automatic
        
        self.setupToHideKeyboardOnTapOnView()
        
        checkDay()
    }
      
}

extension MainScreenViewController: ManageTimers {
    
    func startWorkTimer() {
        <#code#>
    }
    
    func startBreakTimer() {
        <#code#>
    }
    
    func pauseWorkTimer() {
        <#code#>
    }
    
    func pauseBreakTimer() {
        <#code#>
    }
    
    func stop() {
        <#code#>
    }
    
    func startTaskTimer() {
        <#code#>
    }
    
    func stopTaskTimer() {
        <#code#>
    }
}
