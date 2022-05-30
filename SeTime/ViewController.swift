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
    }

//    MARK: - Outlets
    
    @IBOutlet weak var graphicView: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var workButton: UIButton!
    
    @IBOutlet weak var breakButton: UIButton!
    
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet weak var taskField: UITextField!
    
    @IBOutlet weak var startTaskButton: UIButton!
    
    @IBOutlet weak var tasksTableView: UITableView!
    
//    MARK: - Actions
    
    @IBAction func workButtonAction(_ sender: Any) {
    }
    
    @IBAction func breakButtonAction(_ sender: Any) {
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
    }
    
    @IBAction func startTaskButtonAction(_ sender: Any) {
    }
    
    
}

