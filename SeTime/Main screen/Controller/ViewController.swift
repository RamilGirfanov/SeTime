//
//  ViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.05.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIobjects()
    }
      
    
//    MARK: - Экземпляры модели
    
    var dataManager = DataManager()
    var day = Day()
    
    
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

    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        stop()
        
        workButton.isHidden = false
        breakButton.isHidden = true

    }
    
    @IBAction func startTaskButtonAction(_ sender: Any) {
    }
    
//    MARK: - Настройка UI объектов
    
    private func setupUIobjects() {
        
        breakButton.isHidden = true

        let totalCornerRadius: CGFloat = 10
        
        let totalHeightForTappedUIobjets: CGFloat = 34
        
//        Констрейнты
        NSLayoutConstraint.activate([
            workButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjets),
            breakButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjets),
            stopButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjets),
            startTaskButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjets),
            taskField.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjets)
        ])
        
        
//        Радиус
        viewForTime.layer.cornerRadius = totalCornerRadius
        workButton.layer.cornerRadius = totalCornerRadius
        breakButton.layer.cornerRadius = totalCornerRadius
        stopButton.layer.cornerRadius = totalCornerRadius
        startTaskButton.layer.cornerRadius = totalCornerRadius
        taskField.layer.cornerRadius = totalCornerRadius
        tasksTableView.layer.cornerRadius = totalCornerRadius
        
    }
    
}
