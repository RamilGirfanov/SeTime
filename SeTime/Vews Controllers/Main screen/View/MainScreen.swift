//
//  UIViewMainScreen.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 27.10.2022.
//

import UIKit

protocol ManageTimers: AnyObject {
    func startWorkTimer()
    
    func startBreakTimer()
    
    func stop()
    
    func stopTaskTimer()
    
    func addTask()
    
    func showTaskDifinition(index: Int)
        
    func getTasksData() -> [Task]
    
    func deleteTask(index: Int)
}

class MainScreen: UIView {
    
//    MARK: - UIObjects
    
    private var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private var viewForTimeReview: UIView = {
        var viewForTimeReview = UIView()
        viewForTimeReview.backgroundColor = .systemGray6
        viewForTimeReview.layer.cornerRadius = totalCornerRadius
        viewForTimeReview.translatesAutoresizingMaskIntoConstraints = false
        return viewForTimeReview
    }()
    
    private var workTimeTextLabel: UILabel = {
        var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "Время работы"
        workTimeTextLabel.textColor = .systemGray
        workTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    var workTimeDataLabel: UILabel = {
        var workTimeTextLabel = UILabel()
        workTimeTextLabel.text = "-"
        workTimeTextLabel.font = .systemFont(ofSize: textSize1, weight: .regular)
        workTimeTextLabel.textAlignment = .center
        workTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return workTimeTextLabel
    }()
    
    private var stackForTextLabel: UIStackView = {
        var stackForTextLabel = UIStackView()
        stackForTextLabel.axis = .horizontal
        stackForTextLabel.distribution = .fillEqually
        stackForTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTextLabel
    }()
    
    private var totalTimeTextLabel: UILabel = {
        var totalTimeTextLabel = UILabel()
        totalTimeTextLabel.text = "Общее время"
        totalTimeTextLabel.textColor = .systemGray
        totalTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        totalTimeTextLabel.textAlignment = .center
        totalTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeTextLabel
    }()
    
    private var breakTimeTextLabel: UILabel = {
        var breakTimeTextLabel = UILabel()
        breakTimeTextLabel.text = "Время отдыха"
        breakTimeTextLabel.textColor = .systemGray
        breakTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        breakTimeTextLabel.textAlignment = .center
        breakTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeTextLabel
    }()
    
    private var stackForDataLabel: UIStackView = {
        var stackForTextLabel = UIStackView()
        stackForTextLabel.axis = .horizontal
        stackForTextLabel.distribution = .fillEqually
        stackForTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTextLabel
    }()
    
    var totalTimeDataLabel: UILabel = {
        var totalTimeDataLabel = UILabel()
        totalTimeDataLabel.text = "-"
        totalTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        totalTimeDataLabel.textAlignment = .center
        totalTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return totalTimeDataLabel
    }()
    
    var breakTimeDataLabel: UILabel = {
        var breakTimeDataLabel = UILabel()
        breakTimeDataLabel.text = "-"
        breakTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        breakTimeDataLabel.textAlignment = .center
        breakTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return breakTimeDataLabel
    }()
    
    var workButton: UIButton = {
        var workButton = UIButton()
        workButton.setTitle("Работа", for: .normal)
        workButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        workButton.roundYeellowButton()
        return workButton
    }()
    
    var breakButton: UIButton = {
        var breakButton = UIButton()
        breakButton.setTitle("Отдых", for: .normal)
        breakButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        breakButton.isHidden = true
        breakButton.roundYeellowButton()
        return breakButton
    }()
    
    var stopButton: UIButton = {
        var stopButton = UIButton()
        stopButton.setTitle("Стоп", for: .normal)
        stopButton.titleLabel?.font = UIFont.systemFont(ofSize: totalSizeTextInButtons)
        stopButton.roundYeellowButton()
        return stopButton
    }()
    
    var addTaskButton: UIButton = {
        var addTaskButton = UIButton()
        addTaskButton.setTitle("Добавить задачу", for: .normal)
        addTaskButton.setTitleColor(UIColor.systemGray, for: .normal)
        addTaskButton.tintColor = .systemGray
        addTaskButton.backgroundColor = .systemGray6
        addTaskButton.layer.borderWidth = 0.5
        addTaskButton.layer.borderColor = UIColor.lightGray.cgColor
        addTaskButton.layer.cornerRadius = totalCornerRadius
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        addTaskButton.isEnabled = false
        return addTaskButton
    }()
    
    var taskTimerView: UIView = {
        var taskTimerView = UIView()
        taskTimerView.backgroundColor = .systemGray6
        taskTimerView.layer.cornerRadius = totalCornerRadius
        taskTimerView.translatesAutoresizingMaskIntoConstraints = false
        taskTimerView.isHidden = true
        return taskTimerView
    }()
    
    var taskTimeTextLabel: UILabel = {
        var taskTimeTextLabel = UILabel()
        taskTimeTextLabel.text = "Название"
        taskTimeTextLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        taskTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskTimeTextLabel
    }()
    
    var taskTimeDataLabel: UILabel = {
        var taskTimeDataLabel = UILabel()
        taskTimeDataLabel.text = "-"
        taskTimeDataLabel.font = .systemFont(ofSize: textSize3, weight: .regular)
        taskTimeDataLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskTimeDataLabel
    }()
    
    private var stackForTaskLabel: UIStackView = {
        var stackForTaskLabel = UIStackView()
        stackForTaskLabel.axis = .vertical
        stackForTaskLabel.distribution = .fillEqually
        stackForTaskLabel.translatesAutoresizingMaskIntoConstraints = false
        return stackForTaskLabel
    }()
    
    var stopTaskButton: UIButton = {
        var stopTaskButton = UIButton()
        stopTaskButton.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        stopTaskButton.roundYeellowButton()
        return stopTaskButton
    }()
    
    lazy var tasksTableView: UITableView = {
        var tasksTableView = UITableView()
        tasksTableView.backgroundColor = .systemGray6
        tasksTableView.layer.borderWidth = 0.5
        tasksTableView.layer.borderColor = UIColor.lightGray.cgColor
        tasksTableView.layer.cornerRadius = totalCornerRadius
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        return tasksTableView
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: ManageTimers?
    
//    MARK: - Layout
    
    private func layout() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [viewForTimeReview, workButton, breakButton, stopButton, addTaskButton, taskTimerView, tasksTableView].forEach { contentView.addSubview($0) }
        
        [workTimeTextLabel, workTimeDataLabel, stackForTextLabel, stackForDataLabel].forEach { viewForTimeReview.addSubview($0) }
        
        [totalTimeTextLabel, breakTimeTextLabel].forEach { stackForTextLabel.addArrangedSubview($0) }
        [totalTimeDataLabel, breakTimeDataLabel].forEach { stackForDataLabel.addArrangedSubview($0) }
        
        [stackForTaskLabel, stopTaskButton].forEach { taskTimerView.addSubview($0) }
        
        [taskTimeTextLabel, taskTimeDataLabel].forEach { stackForTaskLabel.addArrangedSubview($0) }
        
        
        let safeIndent1: CGFloat = 16
        let safeIndent2: CGFloat = 8
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
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
            
            taskTimerView.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects * 1.5),
            taskTimerView.topAnchor.constraint(equalTo: stopButton.bottomAnchor, constant: safeIndent1 * 2),
            taskTimerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            taskTimerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            
            stackForTaskLabel.topAnchor.constraint(equalTo: taskTimerView.topAnchor),
            stackForTaskLabel.leadingAnchor.constraint(equalTo: taskTimerView.leadingAnchor, constant: safeIndent2),
            stackForTaskLabel.bottomAnchor.constraint(equalTo: taskTimerView.bottomAnchor),
            
            stopTaskButton.heightAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            stopTaskButton.widthAnchor.constraint(equalToConstant: totalHeightForTappedUIobjects),
            stopTaskButton.centerYAnchor.constraint(equalTo: taskTimerView.centerYAnchor),
            stopTaskButton.leadingAnchor.constraint(equalTo: stackForTaskLabel.trailingAnchor, constant: safeIndent2),
            stopTaskButton.trailingAnchor.constraint(equalTo: taskTimerView.trailingAnchor, constant: -safeIndent2),
            
            addTaskButton.topAnchor.constraint(equalTo: taskTimerView.topAnchor),
            addTaskButton.leadingAnchor.constraint(equalTo: taskTimerView.leadingAnchor),
            addTaskButton.trailingAnchor.constraint(equalTo: taskTimerView.trailingAnchor),
            addTaskButton.bottomAnchor.constraint(equalTo: taskTimerView.bottomAnchor),
            
            tasksTableView.topAnchor.constraint(equalTo: taskTimerView.bottomAnchor, constant: safeIndent2),
            tasksTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: safeIndent1),
            tasksTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -safeIndent1),
            tasksTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -safeIndent2)
        ])
    }
    
    
//    MARK: - Настройка кнопок
    
    private func setupButtons() {
        workButton.addTarget(self, action: #selector(tapForWork), for: .touchUpInside)
        breakButton.addTarget(self, action: #selector(tapForBreak), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(tapForStop), for: .touchUpInside)
        stopTaskButton.addTarget(self, action: #selector(stopTask), for: .touchUpInside)
        addTaskButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
//    Запускает таймер работы, в том числе для задачи
    @objc private func tapForWork() {
        delegate?.startWorkTimer()
                
        addTaskButton.setTitleColor(.black, for: .normal)
        addTaskButton.tintColor = .black
        addTaskButton.backgroundColor = mainColorTheme
        addTaskButton.layer.borderWidth = 0
        
        addTaskButton.isEnabled = true
        
        workButton.isHidden = true
        breakButton.isHidden = false
        
        stopTaskButton.isEnabled = true
    }
    
//    Запускает таймер перерывов, в том числе для задачи
    @objc private func tapForBreak() {
        delegate?.startBreakTimer()
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        addTaskButton.setTitleColor(UIColor.systemGray, for: .normal)
        addTaskButton.tintColor = .black
        addTaskButton.backgroundColor = .systemGray6
        addTaskButton.layer.borderWidth = 0.5
        
        addTaskButton.isEnabled = false
    }
    
//    Останавливает все таймеры, в том числе для задачи
    @objc private func tapForStop() {
        delegate?.stop()
        
        addTaskButton.setTitleColor(UIColor.systemGray, for: .normal)
        addTaskButton.tintColor = .black
        addTaskButton.backgroundColor = .systemGray6
        addTaskButton.layer.borderWidth = 0.5
        
        addTaskButton.isEnabled = false
        
        workButton.isHidden = false
        breakButton.isHidden = true
        
        taskTimeTextLabel.text = "Название"
        taskTimeDataLabel.text = "-"
        
        addTaskButton.isHidden = false
        taskTimerView.isHidden = true
        
        tasksTableView.reloadData()
    }
    
//    Останавливает таймер задачи и переносит задачу в таблицу
    @objc private func stopTask() {
        delegate?.stopTaskTimer()
        
        taskTimeTextLabel.text = "Название"
        taskTimeDataLabel.text = "-"
        
        addTaskButton.isHidden = false
        taskTimerView.isHidden = true
        
        tasksTableView.reloadData()
    }
    
//    Вызывает экран запуска задачи
    @objc private func addTask() {
        delegate?.addTask()
    }
    
    
//    MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setupButtons()
        setupToHideKeyboardOnTapOnView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//    MARK: - Расширение UITableViewDataSource

extension MainScreen: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.getTasksData().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        
        guard let tasks = delegate?.getTasksData() else { return cell }
        cell.pullCell(taskData: tasks[indexPath.row])
        
        return cell
    }
}


//    MARK: - Расширение UITableViewDelegate

extension MainScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showTaskDifinition(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") {_,_,_ in

            self.delegate?.deleteTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    }
}


//  MARK: - Расширение для клавиатуры что бы она скрывалась по нажанию на return

extension MainScreen: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}

//  MARK: - Расширение для клавиатуры что бы она скрывалась по нажанию на любое место экрана

extension MainScreen {
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        endEditing(true)
    }
}
