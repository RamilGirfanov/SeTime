//
//  MainScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 16.12.2022.
//

import UIKit

final class MainScreen: UIView {
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIObjects
    
    let viewForTimeReview: ViewForTimeReview = {
        let viewForTimeReview = ViewForTimeReview()
        viewForTimeReview.layer.cornerRadius = totalCornerRadius
        return viewForTimeReview
    }()
    
    let workButton: UIButton = {
        let workButton = UIButton()
        workButton.setTitle(NSLocalizedString("work", comment: ""), for: .normal)
        workButton.activeButton()
        workButton.translatesAutoresizingMaskIntoConstraints = false
        return workButton
    }()
    
    let breakButton: UIButton = {
        let breakButton = UIButton()
        breakButton.setTitle(NSLocalizedString("break", comment: ""), for: .normal)
        breakButton.isHidden = true
        breakButton.activeButton()
        breakButton.translatesAutoresizingMaskIntoConstraints = false
        return breakButton
    }()
    
    let stopButton: UIButton = {
        let stopButton = UIButton()
        stopButton.setTitle(NSLocalizedString("stop", comment: ""), for: .normal)
        stopButton.inactiveButton()
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        return stopButton
    }()
    
    let addTaskButton: UIButton = {
        let addTaskButton = UIButton()
        addTaskButton.setTitle(NSLocalizedString("addTask", comment: ""), for: .normal)
        addTaskButton.inactiveButton()
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        return addTaskButton
    }()
    
    let taskTimerView: UIView = {
        let taskTimerView = UIView()
        taskTimerView.layer.cornerRadius = totalCornerRadius
        taskTimerView.translatesAutoresizingMaskIntoConstraints = false
        taskTimerView.isHidden = true
        return taskTimerView
    }()
    
    let taskTimerSubView: UIView = {
        let taskTimerSubView = UIView()
        taskTimerSubView.backgroundColor = .secondarySystemBackground
        taskTimerSubView.layer.cornerRadius = totalCornerRadius
        taskTimerSubView.translatesAutoresizingMaskIntoConstraints = false
        return taskTimerSubView
    }()
    
    let taskTimeTextLabel: UILabel = {
        let taskTimeTextLabel = UILabel()
        taskTimeTextLabel.text = NSLocalizedString("name", comment: "")
        taskTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        taskTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskTimeTextLabel
    }()
    
    let taskTimeDataLabel: UILabel = {
        let taskTimeDataLabel = UILabel()
        taskTimeDataLabel.text = "00:00:00"
        taskTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        taskTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskTimeDataLabel
    }()
    
    private let stackForTaskLabel: UIStackView = {
        let stackForTaskLabel = UIStackView()
        stackForTaskLabel.axis = .vertical
        stackForTaskLabel.distribution = .fillEqually
        stackForTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTaskLabel
    }()
    
    let stopTaskButton: UIButton = {
        let stopTaskButton = UIButton()
        stopTaskButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        stopTaskButton.activeButton()
        stopTaskButton.translatesAutoresizingMaskIntoConstraints = false
        return stopTaskButton
    }()
    
    lazy var tasksTableView: UITableView = {
        var tasksTableView = UITableView()
        tasksTableView.backgroundColor = .secondarySystemBackground
        tasksTableView.layer.cornerRadius = totalCornerRadius
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        tasksTableView.separatorInset = .zero
        return tasksTableView
    }()
    
    // MARK: - Private Methods
    
    private func layout() {
        [viewForTimeReview, workButton, breakButton, stopButton, addTaskButton, taskTimerView, tasksTableView].forEach { addSubview($0) }
        
        [taskTimerSubView, stopTaskButton].forEach { taskTimerView.addSubview($0) }
        
        taskTimerSubView.addSubview(stackForTaskLabel)
        
        [taskTimeTextLabel, taskTimeDataLabel].forEach { stackForTaskLabel.addArrangedSubview($0) }
        
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8
        
        NSLayoutConstraint.activate([
            viewForTimeReview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: safeIndent1),
            viewForTimeReview.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            viewForTimeReview.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            workButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            workButton.topAnchor.constraint(equalTo: viewForTimeReview.bottomAnchor, constant: safeIndent2),
            workButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            workButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            breakButton.topAnchor.constraint(equalTo: workButton.topAnchor),
            breakButton.leadingAnchor.constraint(equalTo: workButton.leadingAnchor),
            breakButton.trailingAnchor.constraint(equalTo: workButton.trailingAnchor),
            breakButton.bottomAnchor.constraint(equalTo: workButton.bottomAnchor),
            
            stopButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            stopButton.topAnchor.constraint(equalTo: workButton.bottomAnchor, constant: safeIndent2),
            stopButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            stopButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            taskTimerView.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            taskTimerView.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: safeIndent1 * 2),
            taskTimerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            taskTimerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            
            taskTimerSubView.topAnchor.constraint(equalTo: taskTimerView.topAnchor),
            taskTimerSubView.leadingAnchor.constraint(equalTo: taskTimerView.leadingAnchor),
            taskTimerSubView.bottomAnchor.constraint(equalTo: taskTimerView.bottomAnchor),
            
            stackForTaskLabel.centerYAnchor.constraint(equalTo: taskTimerSubView.centerYAnchor),
            stackForTaskLabel.leadingAnchor.constraint(equalTo: taskTimerSubView.leadingAnchor, constant: safeIndent2),
            stackForTaskLabel.trailingAnchor.constraint(equalTo: taskTimerSubView.trailingAnchor, constant: -safeIndent2),
            
            taskTimeTextLabel.leadingAnchor.constraint(equalTo: stackForTaskLabel.leadingAnchor),
            taskTimeTextLabel.trailingAnchor.constraint(equalTo: stackForTaskLabel.trailingAnchor),
            
            taskTimeDataLabel.leadingAnchor.constraint(equalTo: stackForTaskLabel.leadingAnchor),
            taskTimeDataLabel.trailingAnchor.constraint(equalTo: stackForTaskLabel.trailingAnchor),
            
            stopTaskButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            stopTaskButton.widthAnchor.constraint(equalTo: stopTaskButton.heightAnchor),
            stopTaskButton.topAnchor.constraint(equalTo: taskTimerView.topAnchor),
            stopTaskButton.leadingAnchor.constraint(equalTo: taskTimerSubView.trailingAnchor, constant: safeIndent2),
            stopTaskButton.trailingAnchor.constraint(equalTo: taskTimerView.trailingAnchor),
            
            addTaskButton.topAnchor.constraint(equalTo: taskTimerView.topAnchor),
            addTaskButton.leadingAnchor.constraint(equalTo: taskTimerView.leadingAnchor),
            addTaskButton.trailingAnchor.constraint(equalTo: taskTimerView.trailingAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: taskTimerView.bottomAnchor),
            
            tasksTableView.topAnchor.constraint(equalTo: taskTimerView.bottomAnchor, constant: safeIndent2),
            tasksTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: safeIndent1),
            tasksTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -safeIndent1),
            tasksTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -safeIndent2)
        ])
    }
    
    // MARK: - Public Methods
    
    func activateWorkMode() {
        addTaskButton.activeButton()
        stopButton.activeButton()
        
        workButton.isHidden = true
        breakButton.isHidden = false
        
        viewForTimeReview.leftFocusView.isHidden = false
        viewForTimeReview.rightFocusView.isHidden = true
        
        stopTaskButton.isEnabled = true
    }
    
    func activateBreakMode() {
        addTaskButton.inactiveButton()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        viewForTimeReview.leftFocusView.isHidden = true
        viewForTimeReview.rightFocusView.isHidden = false
    }
    
    func activateStopMode() {
        addTaskButton.inactiveButton()
        stopButton.inactiveButton()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        taskTimeTextLabel.text = NSLocalizedString("name", comment: "")
        taskTimeDataLabel.text = "00:00:00"
        
        addTaskButton.isHidden = false
        taskTimerView.isHidden = true
        
        viewForTimeReview.leftFocusView.isHidden = true
        viewForTimeReview.rightFocusView.isHidden = true
        
        tasksTableView.reloadData()
    }
    
    func activateAddTaskMode(taskName: String) {
        stopButton.activeButton()
        
        workButton.isHidden = true
        breakButton.isHidden = false
        
        viewForTimeReview.leftFocusView.isHidden = false
        viewForTimeReview.rightFocusView.isHidden = true
        
        stopTaskButton.isEnabled = true

        addTaskButton.isHidden = true
        taskTimerView.isHidden = false
        
        taskTimeTextLabel.text = taskName
        tasksTableView.reloadData()
    }
    
    func activateStopTaskMode() {
        taskTimeTextLabel.text = NSLocalizedString("name", comment: "")
        taskTimeDataLabel.text = "00:00:00"
        
        addTaskButton.isHidden = false
        taskTimerView.isHidden = true
        
        addTaskButton.activeButton()
        
        tasksTableView.reloadData()
    }
    
    func activateRestartTaskMode(taskName: String, time: Int) {
        stopButton.activeButton()
        
        workButton.isHidden = true
        breakButton.isHidden = false
        
        viewForTimeReview.leftFocusView.isHidden = false
        viewForTimeReview.rightFocusView.isHidden = true
        
        stopTaskButton.isEnabled = true

        addTaskButton.isHidden = true
        taskTimerView.isHidden = false
        
        taskTimeTextLabel.text = taskName
        taskTimeDataLabel.text = timeIntToString(time: time)
        
        tasksTableView.reloadData()
    }
    
    // Функция для инициирования нового дня
    func newDay() {
        // Настройка видимости кнопок
        workButton.isHidden = false
        breakButton.isHidden = true
        addTaskButton.isEnabled = false
        
        // Очистка экрана от данных
        viewForTimeReview.workTimeDataLabel.text = "00:00:00"
        viewForTimeReview.breakTimeDataLabel.text = "00:00:00"
        viewForTimeReview.totalTimeDataLabel.text = "00:00:00"
        tasksTableView.reloadData()
    }
    
    // Функция для инициирования текущего дня
    func currentDay(day: Day) {
        viewForTimeReview.workTimeDataLabel.text = timeIntToString(time: day.workTime)
        viewForTimeReview.breakTimeDataLabel.text = timeIntToString(time: day.breakTime)
        viewForTimeReview.totalTimeDataLabel.text = timeIntToString(time: day.totalTime)
        tasksTableView.reloadData()
    }
}
