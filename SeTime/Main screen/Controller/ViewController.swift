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
//        setupTableView()
//        setupUIobjects()
        layout()
        setupButtons()
    }
      
    
    //    MARK: - UIobjects
    
    private lazy var scrollView: UIScrollView = {
        lazy var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        lazy var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var viewForTimeReview: UIView = {
        lazy var viewForTimeReview = UIView()
        viewForTimeReview.backgroundColor = .systemGray6
        viewForTimeReview.layer.cornerRadius = totalCornerRadius
        viewForTimeReview.translatesAutoresizingMaskIntoConstraints = false
        return viewForTimeReview
    }()
    
    private lazy var reviewTimeLabel: UILabel = {
        lazy var timeTextLabel = UILabel()
        timeTextLabel.text = "Обзор времени"
        timeTextLabel.font = .systemFont(ofSize: 17, weight: .bold)
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeTextLabel
    }()
    
    private lazy var workTimeTextLabel: UILabel = {
        lazy var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "Время работы"
        workTimeTextLabel.textColor = .systemGray
        workTimeTextLabel.font = .systemFont(ofSize: 12, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    lazy var workTimeDataLabel: UILabel = {
        lazy var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "0c"
        workTimeTextLabel.font = .systemFont(ofSize: 20, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    private lazy var stackForTextLabel: UIStackView = {
        lazy var stackForTextLabel = UIStackView()
        stackForTextLabel.axis = .horizontal
        stackForTextLabel.distribution = .fillEqually
        stackForTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTextLabel
    }()
    
    lazy var totalTimeTextLabel: UILabel = {
        lazy var totalTimeTextLabel = UILabel()
        totalTimeTextLabel.text = "Общее время"
        totalTimeTextLabel.textColor = .systemGray
        totalTimeTextLabel.font = .systemFont(ofSize: 10, weight: .regular)
        totalTimeTextLabel.textAlignment = .center
        totalTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeTextLabel
    }()
    
    lazy var breakTimeTextLabel: UILabel = {
        lazy var breakTimeTextLabel = UILabel()
        breakTimeTextLabel.text = "Время перерывов"
        breakTimeTextLabel.textColor = .systemGray
        breakTimeTextLabel.font = .systemFont(ofSize: 10, weight: .regular)
        breakTimeTextLabel.textAlignment = .center
        breakTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeTextLabel
    }()
    
    lazy var stackForDataLabel: UIStackView = {
        lazy var stackForTextLabel = UIStackView()
        stackForTextLabel.axis = .horizontal
        stackForTextLabel.distribution = .fillEqually
        stackForTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTextLabel
    }()
    
    lazy var totalTimeDataLabel: UILabel = {
        lazy var totalTimeDataLabel = UILabel()
        totalTimeDataLabel.text = "0с"
        totalTimeDataLabel.font = .systemFont(ofSize: 10, weight: .regular)
        totalTimeDataLabel.textAlignment = .center
        totalTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeDataLabel
    }()
    
    lazy var breakTimeDataLabel: UILabel = {
        lazy var breakTimeDataLabel = UILabel()
        breakTimeDataLabel.text = "0с"
        breakTimeDataLabel.font = .systemFont(ofSize: 10, weight: .regular)
        breakTimeDataLabel.textAlignment = .center
        breakTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeDataLabel
    }()
    
    private lazy var workButton: UIButton = {
        lazy var workButton = UIButton()
        workButton.setTitle("Работа", for: .normal)
        workButton.tintColor = .black
        workButton.backgroundColor = .systemYellow
        workButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        workButton.translatesAutoresizingMaskIntoConstraints = false
        return workButton
    }()
    
    private lazy var breakButton: UIButton = {
        lazy var breakButton = UIButton()
        breakButton.setTitle("Отдых", for: .normal)
        breakButton.tintColor = .black
        breakButton.backgroundColor = .systemYellow
        breakButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        breakButton.isHidden = true
        breakButton.translatesAutoresizingMaskIntoConstraints = false
        return breakButton
    }()

    private lazy var stopButton: UIButton = {
        lazy var stopButton = UIButton()
        stopButton.setTitle("Стоп", for: .normal)
        stopButton.tintColor = .black
        stopButton.backgroundColor = .systemYellow
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        return stopButton
    }()
    
    private lazy var reviewTasksLabel: UILabel = {
        lazy var reviewTasksLabel = UILabel()
        reviewTasksLabel.text = "Обзор задач"
        reviewTasksLabel.font = .systemFont(ofSize: 17, weight: .bold)
        reviewTasksLabel.translatesAutoresizingMaskIntoConstraints = false
        return reviewTasksLabel
    }()

    private lazy var viewForTextField: UIView = {
        lazy var viewForTextField = UIView()
        viewForTextField.clipsToBounds = true
        viewForTextField.layer.cornerRadius = totalCornerRadius
        viewForTextField.translatesAutoresizingMaskIntoConstraints = false
        return viewForTextField
    }()
    
    lazy var textFieldForTasks: UITextField = {
        lazy var textFieldForTasks = UITextField()
        textFieldForTasks.placeholder = "Задача"
        textFieldForTasks.font = .systemFont(ofSize: 12)
        textFieldForTasks.tintColor = .systemYellow
        textFieldForTasks.translatesAutoresizingMaskIntoConstraints = false
        return textFieldForTasks
    }()
    
    private lazy var taskButton: UIButton = {
        lazy var taskButton = UIButton()
        taskButton.setTitle("Добавить", for: .normal)
        taskButton.tintColor = .black
        taskButton.backgroundColor = .systemYellow
        taskButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        taskButton.translatesAutoresizingMaskIntoConstraints = false
        return taskButton
    }()
    
    private lazy var tasksTableView: UITableView = {
        lazy var tasksTableView = UITableView()
        tasksTableView.backgroundColor = .systemGray6
        tasksTableView.layer.cornerRadius = totalCornerRadius
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        return tasksTableView
    }()
    
    
//    MARK: - Настройка таргетов кнопок
    
    private func setupButtons() {
        workButton.addTarget(self, action: #selector(tapForWork), for: .touchUpInside)
        breakButton.addTarget(self, action: #selector(tapForBreak), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(tapForStop), for: .touchUpInside)

    }
    
    @objc func tapForWork() {
        startWorkTimer()
        pauseBreakTimer()
        
        workButton.isHidden = true
        breakButton.isHidden = false
    }
    
    @objc func tapForBreak() {
        pauseWorkTimer()
        startBreakTimer()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        cellDelegate?.stopTaskTimer()
    }
    
    @objc func tapForStop() {
        stop()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        cellDelegate?.stopTaskTimer()
    }
    
    
    //    MARK: - Настройка констрейнтов
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [reviewTimeLabel, viewForTimeReview, workButton, breakButton, stopButton, reviewTasksLabel, viewForTextField, taskButton, tasksTableView].forEach { contentView.addSubview($0) }
        [workTimeTextLabel, workTimeDataLabel, stackForTextLabel, stackForDataLabel].forEach { viewForTimeReview.addSubview($0) }
        [totalTimeTextLabel, breakTimeTextLabel].forEach { stackForTextLabel.addSubview($0) }
        [totalTimeDataLabel, breakTimeDataLabel].forEach { stackForDataLabel.addSubview($0) }
        viewForTextField.addSubview(textFieldForTasks)
        
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            reviewTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeIndent1),
            reviewTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            viewForTimeReview.topAnchor.constraint(equalTo: reviewTimeLabel.bottomAnchor, constant: safeIndent2),
            viewForTimeReview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            viewForTimeReview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            workTimeTextLabel.topAnchor.constraint(equalTo: viewForTimeReview.topAnchor, constant: safeIndent1),
            workTimeTextLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            workTimeTextLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            
            workTimeDataLabel.topAnchor.constraint(equalTo: workTimeTextLabel.bottomAnchor),
            workTimeDataLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            workTimeDataLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            
            stackForTextLabel.topAnchor.constraint(equalTo: workTimeDataLabel.bottomAnchor, constant: safeIndent1),
            stackForTextLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            stackForTextLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            
            stackForDataLabel.topAnchor.constraint(equalTo: stackForTextLabel.bottomAnchor),
            stackForDataLabel.leadingAnchor.constraint(equalTo: viewForTimeReview.leadingAnchor),
            stackForDataLabel.trailingAnchor.constraint(equalTo: viewForTimeReview.trailingAnchor),
            stackForDataLabel.bottomAnchor.constraint(equalTo: viewForTimeReview.bottomAnchor),
            
            workButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            workButton.widthAnchor.constraint(equalToConstant: totalWidthForTasksButtons),
            workButton.topAnchor.constraint(equalTo: viewForTimeReview.bottomAnchor, constant: safeIndent2),
            workButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            workButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            breakButton.topAnchor.constraint(equalTo: workButton.topAnchor),
            breakButton.leadingAnchor.constraint(equalTo: workButton.leadingAnchor),
            breakButton.trailingAnchor.constraint(equalTo: workButton.trailingAnchor),
            breakButton.bottomAnchor.constraint(equalTo: workButton.bottomAnchor),
            
            stopButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            stopButton.widthAnchor.constraint(equalToConstant: totalWidthForTasksButtons),
            stopButton.topAnchor.constraint(equalTo: workButton.bottomAnchor, constant: safeIndent2),
            stopButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            stopButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            reviewTasksLabel.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: safeIndent1 * 2),
            reviewTasksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            viewForTextField.topAnchor.constraint(equalTo: reviewTasksLabel.bottomAnchor, constant: safeIndent2),
            viewForTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            taskButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            taskButton.widthAnchor.constraint(equalToConstant: totalWidthForTasksButtons),
            taskButton.topAnchor.constraint(equalTo: viewForTextField.topAnchor),
            taskButton.leadingAnchor.constraint(equalTo: viewForTextField.trailingAnchor, constant: safeIndent2),
            taskButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            tasksTableView.topAnchor.constraint(equalTo: viewForTextField.bottomAnchor, constant: safeIndent2),
            tasksTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            tasksTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            tasksTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }

    
    
    
    
 /*
    
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
    
  */
    
//    MARK: - Делегат ячейки
    
    var cellDelegate: CellManagement?
    
}
