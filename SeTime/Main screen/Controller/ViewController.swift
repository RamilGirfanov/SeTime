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
        self.setupToHideKeyboardOnTapOnView()
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
        timeTextLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        timeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeTextLabel
    }()
    
    private lazy var workTimeTextLabel: UILabel = {
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
        workTimeTextLabel.text = "0c"
        workTimeTextLabel.font = .systemFont(ofSize: textSize1, weight: .regular)
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
    
    private lazy var totalTimeTextLabel: UILabel = {
        lazy var totalTimeTextLabel = UILabel()
        totalTimeTextLabel.text = "Общее время"
        totalTimeTextLabel.textColor = .systemGray
        totalTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        totalTimeTextLabel.textAlignment = .center
        totalTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return totalTimeTextLabel
    }()
    
    private lazy var breakTimeTextLabel: UILabel = {
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
        totalTimeDataLabel.text = "0с"
        totalTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        totalTimeDataLabel.textAlignment = .center
        totalTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeDataLabel
    }()
    
    lazy var breakTimeDataLabel: UILabel = {
        lazy var breakTimeDataLabel = UILabel()
        breakTimeDataLabel.text = "0с"
        breakTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        breakTimeDataLabel.textAlignment = .center
        breakTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeDataLabel
    }()
    
    private lazy var workButton: UIButton = {
        lazy var workButton = UIButton()
        workButton.setTitle("Работа", for: .normal)
        workButton.setTitleColor(.black, for: .normal)
        workButton.backgroundColor = .systemYellow
        workButton.layer.cornerRadius = totalCornerRadius
        workButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        workButton.translatesAutoresizingMaskIntoConstraints = false
        return workButton
    }()
    
    private lazy var breakButton: UIButton = {
        lazy var breakButton = UIButton()
        breakButton.setTitle("Отдых", for: .normal)
        breakButton.setTitleColor(.black, for: .normal)
        breakButton.tintColor = .black
        breakButton.backgroundColor = .systemYellow
        breakButton.layer.cornerRadius = totalCornerRadius
        breakButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        breakButton.isHidden = true
        breakButton.translatesAutoresizingMaskIntoConstraints = false
        return breakButton
    }()

    private lazy var stopButton: UIButton = {
        lazy var stopButton = UIButton()
        stopButton.setTitle("Стоп", for: .normal)
        stopButton.setTitleColor(.black, for: .normal)
        stopButton.tintColor = .black
        stopButton.backgroundColor = .systemYellow
        stopButton.layer.cornerRadius = totalCornerRadius
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        return stopButton
    }()
    
    private lazy var reviewTasksLabel: UILabel = {
        lazy var reviewTasksLabel = UILabel()
        reviewTasksLabel.text = "Обзор задач"
        reviewTasksLabel.font = .systemFont(ofSize: textSize1, weight: .bold)
        reviewTasksLabel.translatesAutoresizingMaskIntoConstraints = false
        return reviewTasksLabel
    }()

    private lazy var viewForTextField: UIView = {
        lazy var viewForTextField = UIView()
        viewForTextField.clipsToBounds = true
        viewForTextField.layer.cornerRadius = totalCornerRadius
        viewForTextField.layer.borderWidth = 0.5
        viewForTextField.layer.borderColor = UIColor.lightGray.cgColor
        viewForTextField.translatesAutoresizingMaskIntoConstraints = false
        return viewForTextField
    }()
    
    lazy var textFieldForTasks: UITextField = {
        lazy var textFieldForTasks = UITextField()
        textFieldForTasks.placeholder = "Задача"
        textFieldForTasks.font = .systemFont(ofSize: textSize4)
        textFieldForTasks.backgroundColor = .systemGray6
        textFieldForTasks.tintColor = .systemYellow
        textFieldForTasks.borderStyle = .roundedRect
        textFieldForTasks.translatesAutoresizingMaskIntoConstraints = false
        textFieldForTasks.delegate = self
        return textFieldForTasks
    }()
    
    private lazy var taskButton: UIButton = {
        lazy var taskButton = UIButton()
        taskButton.setTitle("Добавить", for: .normal)
        taskButton.setTitleColor(.black, for: .normal)
        taskButton.tintColor = .black
        taskButton.backgroundColor = .systemYellow
        taskButton.layer.cornerRadius = totalCornerRadius
        taskButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        taskButton.translatesAutoresizingMaskIntoConstraints = false
        return taskButton
    }()
    
    lazy var tasksTableView: UITableView = {
        lazy var tasksTableView = UITableView()
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
        taskButton.addTarget(self, action: #selector(tapForTask), for: .touchUpInside)
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
        
        for i in arrayOfCells {
            i.stopTaskTimer()
        }
    }
    
    @objc func tapForStop() {
        stop()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        for i in arrayOfCells {
            i.stopTaskTimer()
        }
    }
    
    @objc func tapForTask() {
        newTask()
        textFieldForTasks.text = ""
    }
    
    
    //    MARK: - Настройка констрейнтов
    
    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [reviewTimeLabel, viewForTimeReview, workButton, breakButton, stopButton, reviewTasksLabel, viewForTextField, taskButton, tasksTableView].forEach { contentView.addSubview($0) }
        
        [workTimeTextLabel, workTimeDataLabel, stackForTextLabel, stackForDataLabel].forEach { viewForTimeReview.addSubview($0) }
        
        [totalTimeTextLabel, breakTimeTextLabel].forEach { stackForTextLabel.addArrangedSubview($0) }
        
        [totalTimeDataLabel, breakTimeDataLabel].forEach { stackForDataLabel.addArrangedSubview($0) }
        
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
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
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
            stackForDataLabel.bottomAnchor.constraint(equalTo: viewForTimeReview.bottomAnchor, constant: -safeIndent1),
            
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
            
            viewForTextField.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            viewForTextField.topAnchor.constraint(equalTo: reviewTasksLabel.bottomAnchor, constant: safeIndent2),
            viewForTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            
            textFieldForTasks.topAnchor.constraint(equalTo: viewForTextField.topAnchor),
            textFieldForTasks.leadingAnchor.constraint(equalTo: viewForTextField.leadingAnchor),
            textFieldForTasks.trailingAnchor.constraint(equalTo: viewForTextField.trailingAnchor),
            textFieldForTasks.bottomAnchor.constraint(equalTo: viewForTextField.bottomAnchor),
            
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
    
    
//    MARK: - Notification center для приподнития ScrollView при вызове клавиатуры
    
    private let nc = NotificationCenter.default
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nc.addObserver(self, selector: #selector(kbShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func kbShow(notification: NSNotification) {
        if let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
        }
    }
    
    @objc private func kbHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
