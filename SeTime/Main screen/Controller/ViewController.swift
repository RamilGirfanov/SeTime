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
        setupTableView()
        setupUIobjects()
    }
      
    
//    MARK: - Outlets
    
    @IBOutlet weak var viewForTime: UIView!
    
    @IBOutlet weak var workTimeLabel: UILabel!
    
    @IBOutlet weak var breakTimeLabel: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var workButton: UIButton!
    
    @IBOutlet weak var breakButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var taskField: UITextField!
    
    @IBOutlet weak var startTaskButton: UIButton!
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    
//    MARK: - Actions
    
    @IBAction func workButtonAction(_ sender: Any) {
        startWorkTimer()
        pauseBreakTimer()
        breakButton.isEnabled = true
        
        workButton.isHidden = true
        breakButton.isHidden = false
    }
    
    @IBAction func breakButtonAction(_ sender: Any) {
        pauseWorkTimer()
        startBreakTimer()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        cellDelegate?.stopTaskTimer()
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        stop()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        cellDelegate?.stopTaskTimer()
    }
    
    @IBAction func startTaskButtonAction(_ sender: Any) {
        newTask()
    }
    
//    MARK: - Настройка UI объектов
    
    private func setupUIobjects() {
        
        breakButton.isHidden = true
        
//        Констрейнты
        NSLayoutConstraint.activate([
            workButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            breakButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            stopButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            startTaskButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            taskField.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            startTaskButton.widthAnchor.constraint(equalToConstant: totalWidthForTasksButtons)
        ])
        
//        Радиус
        viewForTime.layer.cornerRadius = totalCornerRadius
        workButton.layer.cornerRadius = totalCornerRadius
        breakButton.layer.cornerRadius = totalCornerRadius
        stopButton.layer.cornerRadius = totalCornerRadius
        startTaskButton.layer.cornerRadius = totalCornerRadius
        taskField.layer.cornerRadius = totalCornerRadius
        tasksTableView.layer.cornerRadius = totalCornerRadius
        
//        Размер шрифра в кнопках
        workButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        breakButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        startTaskButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
    }
    
    private func setupTableView(){
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
    }
    
//    MARK: - Делегат ячейки
    
    var cellDelegate: CellManagement?
    
}
