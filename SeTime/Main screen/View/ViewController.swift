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
      
    
    //    MARK: - UIObjects
    
    lazy var scrollView: UIScrollView = {
        lazy var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        lazy var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    lazy var viewForTimeReview: UIView = {
        lazy var viewForTimeReview = UIView()
        viewForTimeReview.backgroundColor = .systemGray6
        viewForTimeReview.layer.cornerRadius = totalCornerRadius
        viewForTimeReview.translatesAutoresizingMaskIntoConstraints = false
        return viewForTimeReview
    }()
    
    lazy var workTimeTextLabel: UILabel = {
        lazy var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "Время работы"
        workTimeTextLabel.textColor = .systemGray
        workTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    lazy var workTimeDataLabel: UILabel = {
        lazy var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "-"
        workTimeTextLabel.font = .systemFont(ofSize: textSize1, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    lazy var stackForTextLabel: UIStackView = {
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
        totalTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        totalTimeTextLabel.textAlignment = .center
        totalTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeTextLabel
    }()
    
    lazy var breakTimeTextLabel: UILabel = {
        lazy var breakTimeTextLabel = UILabel()
        breakTimeTextLabel.text = "Время отдыха"
        breakTimeTextLabel.textColor = .systemGray
        breakTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
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
        totalTimeDataLabel.text = "-"
        totalTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        totalTimeDataLabel.textAlignment = .center
        totalTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeDataLabel
    }()
    
    lazy var breakTimeDataLabel: UILabel = {
        lazy var breakTimeDataLabel = UILabel()
        breakTimeDataLabel.text = "-"
        breakTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        breakTimeDataLabel.textAlignment = .center
        breakTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeDataLabel
    }()
    
    lazy var workButton: UIButton = {
        lazy var workButton = UIButton()
        workButton.setTitle("Работа", for: .normal)
        workButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        workButton.roundYeellowButton()
        return workButton
    }()
    
    lazy var breakButton: UIButton = {
        lazy var breakButton = UIButton()
        breakButton.setTitle("Отдых", for: .normal)
        breakButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        breakButton.isHidden = true
        breakButton.roundYeellowButton()
        return breakButton
    }()

    lazy var stopButton: UIButton = {
        lazy var stopButton = UIButton()
        stopButton.setTitle("Стоп", for: .normal)
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        stopButton.roundYeellowButton()
        return stopButton
    }()
    
    static var addTaskButton: UIButton = {
        lazy var addTaskButton = UIButton()
        addTaskButton.setTitle("Добавить задачу", for: .normal)
        addTaskButton.setTitleColor(UIColor.systemGray, for: .normal)
        addTaskButton.tintColor = .systemGray
        addTaskButton.backgroundColor = .systemGray6
        addTaskButton.layer.borderWidth = 0.5
        addTaskButton.layer.borderColor = UIColor.lightGray.cgColor
        addTaskButton.layer.cornerRadius = totalCornerRadius
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        return addTaskButton
    }()
    
    static var taskTimerView: UIView = {
        lazy var taskTimerView = UIView()
        taskTimerView.backgroundColor = .systemGray6
        taskTimerView.layer.cornerRadius = totalCornerRadius
        taskTimerView.translatesAutoresizingMaskIntoConstraints = false
        taskTimerView.isHidden = true
        return taskTimerView
    }()
    
    static var taskTimeTextLabel: UILabel = {
        lazy var taskTimeTextLabel = UILabel()
        taskTimeTextLabel.text = "Название"
        taskTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        taskTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskTimeTextLabel
    }()
    
    static var taskTimeDataLabel: UILabel = {
        lazy var taskTimeDataLabel = UILabel()
        taskTimeDataLabel.text = "-"
        taskTimeDataLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        taskTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskTimeDataLabel
    }()
    
    lazy var stackForTaskLabel: UIStackView = {
        lazy var stackForTaskLabel = UIStackView()
        stackForTaskLabel.axis = .vertical
        stackForTaskLabel.distribution = .fillEqually
        stackForTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTaskLabel
    }()
    
    lazy var stopTaskButton: UIButton = {
        lazy var stopTaskButton = UIButton()
        stopTaskButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        stopTaskButton.roundYeellowButton()
        return stopTaskButton
    }()
    
    lazy var tasksTableView: UITableView = {
        lazy var tasksTableView = UITableView()
        tasksTableView.backgroundColor = .systemGray6
        tasksTableView.layer.cornerRadius = totalCornerRadius
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        return tasksTableView
    }()
    
    
    //    MARK: - Layout
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [viewForTimeReview, workButton, breakButton, stopButton, ViewController.addTaskButton, ViewController.taskTimerView, tasksTableView].forEach { contentView.addSubview($0) }
        
        [workTimeTextLabel, workTimeDataLabel, stackForTextLabel, stackForDataLabel].forEach { viewForTimeReview.addSubview($0) }
        
        [totalTimeTextLabel, breakTimeTextLabel].forEach { stackForTextLabel.addArrangedSubview($0) }
        [totalTimeDataLabel, breakTimeDataLabel].forEach { stackForDataLabel.addArrangedSubview($0) }
        
        [stackForTaskLabel, stopTaskButton].forEach { ViewController.taskTimerView.addSubview($0) }
                
        [ViewController.taskTimeTextLabel, ViewController.taskTimeDataLabel].forEach { stackForTaskLabel.addArrangedSubview($0) }
        
        
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
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                        
            viewForTimeReview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: safeIndent1),
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
            stackForDataLabel.bottomAnchor.constraint(equalTo: viewForTimeReview.bottomAnchor, constant: -safeIndent1),
            
            workButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            workButton.topAnchor.constraint(equalTo: viewForTimeReview.bottomAnchor, constant: safeIndent2),
            workButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            workButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            breakButton.topAnchor.constraint(equalTo: workButton.topAnchor),
            breakButton.leadingAnchor.constraint(equalTo: workButton.leadingAnchor),
            breakButton.trailingAnchor.constraint(equalTo: workButton.trailingAnchor),
            breakButton.bottomAnchor.constraint(equalTo: workButton.bottomAnchor),
            
            stopButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            stopButton.topAnchor.constraint(equalTo: workButton.bottomAnchor, constant: safeIndent2),
            stopButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            stopButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            ViewController.taskTimerView.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 1.5),
            ViewController.taskTimerView.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: safeIndent1 * 2),
            ViewController.taskTimerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            ViewController.taskTimerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            stackForTaskLabel.topAnchor.constraint(equalTo: ViewController.taskTimerView.topAnchor),
            stackForTaskLabel.leadingAnchor.constraint(equalTo: ViewController.taskTimerView.leadingAnchor, constant: safeIndent2),
            stackForTaskLabel.bottomAnchor.constraint(equalTo: ViewController.taskTimerView.bottomAnchor),
            
            stopTaskButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            stopTaskButton.widthAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            stopTaskButton.centerYAnchor.constraint(equalTo: ViewController.taskTimerView.centerYAnchor),
            stopTaskButton.leadingAnchor.constraint(equalTo: stackForTaskLabel.trailingAnchor, constant: safeIndent2),
            stopTaskButton.trailingAnchor.constraint(equalTo: ViewController.taskTimerView.trailingAnchor, constant: -safeIndent2),
            
            ViewController.addTaskButton.topAnchor.constraint(equalTo: ViewController.taskTimerView.topAnchor),
            ViewController.addTaskButton.leadingAnchor.constraint(equalTo: ViewController.taskTimerView.leadingAnchor),
            ViewController.addTaskButton.trailingAnchor.constraint(equalTo: ViewController.taskTimerView.trailingAnchor),
            ViewController.addTaskButton.bottomAnchor.constraint(equalTo: ViewController.taskTimerView.bottomAnchor),

            tasksTableView.topAnchor.constraint(equalTo: ViewController.taskTimerView.bottomAnchor, constant: safeIndent2),
            tasksTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            tasksTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            tasksTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent2)
        ])
        
    }
    
}
