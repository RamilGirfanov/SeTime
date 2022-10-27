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
      
    
//    MARK: - Notification center для приподнития ScrollView при вызове клавиатуры

    var nc: NotificationCenter { NotificationCenter.default }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        nc.addObserver(self, selector: #selector(kbShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbShow(notification: NSNotification) {
        if let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            mainScreen.scrollView.contentInset.bottom = kbSize.height
            mainScreen.scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        }
    }
    
    @objc private func kbHide() {
        mainScreen.scrollView.contentInset = .zero
        mainScreen.scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
