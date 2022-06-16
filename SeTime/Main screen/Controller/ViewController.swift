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
        setupView()
    }
      
    
    
    
    
//    Создаем экземпляр модели
    var dataManager = DataManager()
    
    
    
    
    
    
    
//    MARK: - Outlets
        
    @IBOutlet weak var workTimeLabel: UILabel!
    
    @IBOutlet weak var breakTimeLabel: UILabel!
    
    @IBOutlet weak var workButton: UIButton!
    
    @IBOutlet weak var breakButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var taskField: UITextField!
    
    @IBOutlet weak var startTaskButton: UIButton!
    
    @IBOutlet weak var tasksTableView: UITableView!
    
//    Радиус скругления для всех UI объектов на экране
    let totalCornerRadius = 10
    
    
    
    
    
//    MARK: - Actions
    
    @IBAction func workButtonAction(_ sender: Any) {
        
//        dataManager.startWorkTimer()
//
//        workTimeLabel.text = String(dataManager.stopwatch.timeOfWork)
//
//        breakButton.isEnabled = true
        
    }
    
    @IBAction func breakButtonAction(_ sender: Any) {
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        
        breakButton.isEnabled = false
    }
    
    @IBAction func startTaskButtonAction(_ sender: Any) {
    }
        
    
    
    
    
    
//    MARK: - Настройка View
    
    private func setupView() {
        if dataManager.launched == false {
            breakButton.isEnabled = false
        }
    }
    
}


