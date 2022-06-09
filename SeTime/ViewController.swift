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
        ///Делегирование
        ///Есть ли проблема сильных сылок?
        delegateToModel = model
        
        ///А может так?
        ///Где тогда будет храниться файл модели?
        ///Если пользователь закроет приложение?
        var model_2 = Model()
        delegateToModel = model_2
    }

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
        
    }
    
    @IBAction func breakButtonAction(_ sender: Any) {
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
    }
    
    @IBAction func startTaskButtonAction(_ sender: Any) {
    }
    
    var delegateToModel: TimerDayManagement?
    
}

