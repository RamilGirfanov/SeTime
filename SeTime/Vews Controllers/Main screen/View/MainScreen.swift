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
    func restartTask(index: Int)
}

class MainScreen: UIView {
    
//    MARK: - UIObjects
        
    var viewForTimeReview: ViewForTimeReview = {
        var viewForTimeReview = ViewForTimeReview()
        viewForTimeReview.layer.cornerRadius = totalCornerRadius
        return viewForTimeReview
    }()
    
    var workButton: UIButton = {
        var workButton = UIButton()
        workButton.setTitle(NSLocalizedString("work", comment: ""), for: .normal)
        workButton.activeButton()
        workButton.translatesAutoresizingMaskIntoConstraints = false
        return workButton
    }()
    
    var breakButton: UIButton = {
        var breakButton = UIButton()
        breakButton.setTitle(NSLocalizedString("break", comment: ""), for: .normal)
        breakButton.isHidden = true
        breakButton.activeButton()
        breakButton.translatesAutoresizingMaskIntoConstraints = false
        return breakButton
    }()
    
    var stopButton: UIButton = {
        var stopButton = UIButton()
        stopButton.setTitle(NSLocalizedString("stop", comment: ""), for: .normal)
        stopButton.inactiveButton()
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        return stopButton
    }()
    
    var addTaskButton: UIButton = {
        var addTaskButton = UIButton()
        addTaskButton.setTitle(NSLocalizedString("addTask", comment: ""), for: .normal)
        addTaskButton.inactiveButton()
        addTaskButton.translatesAutoresizingMaskIntoConstraints = false
        return addTaskButton
    }()
    
    var taskTimerView: UIView = {
        var taskTimerView = UIView()
        taskTimerView.layer.cornerRadius = totalCornerRadius
        taskTimerView.translatesAutoresizingMaskIntoConstraints = false
        taskTimerView.isHidden = true
        return taskTimerView
    }()
    
    var taskTimerSubView: UIView = {
        var taskTimerSubView = UIView()
        taskTimerSubView.backgroundColor = .secondarySystemBackground
        taskTimerSubView.layer.cornerRadius = totalCornerRadius
        taskTimerSubView.translatesAutoresizingMaskIntoConstraints = false
        return taskTimerSubView
    }()
    
    var taskTimeTextLabel: UILabel = {
        var taskTimeTextLabel = UILabel()
        taskTimeTextLabel.text = NSLocalizedString("name", comment: "")
        taskTimeTextLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
        taskTimeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return taskTimeTextLabel
    }()
    
    var taskTimeDataLabel: UILabel = {
        var taskTimeDataLabel = UILabel()
        taskTimeDataLabel.text = ""
        taskTimeDataLabel.font = .systemFont(ofSize: textSize2, weight: .regular)
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
        stopTaskButton.activeButton()
        stopTaskButton.translatesAutoresizingMaskIntoConstraints = false
        return stopTaskButton
    }()
    
    lazy var tasksTableView: UITableView = {
        var tasksTableView = UITableView()
        tasksTableView.backgroundColor = .secondarySystemBackground
        tasksTableView.layer.cornerRadius = totalCornerRadius
        tasksTableView.translatesAutoresizingMaskIntoConstraints = false
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        tasksTableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.identifier)
        tasksTableView.separatorInset = .zero
        return tasksTableView
    }()
    
    
//    MARK: - Delegate
    
    weak var delegate: ManageTimers?
    
    
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
    }
    
//    Запускает таймер перерывов, в том числе для задачи
    @objc private func tapForBreak() {
        delegate?.startBreakTimer()
    }
    
//    Останавливает все таймеры, в том числе для задачи
    @objc private func tapForStop() {
        delegate?.stop()
    }
    
//    Останавливает таймер задачи и переносит задачу в таблицу
    @objc private func stopTask() {
        delegate?.stopTaskTimer()
    }
    
//    Вызывает экран запуска задачи
    @objc private func addTask() {
        delegate?.addTask()
    }
    
    
//    MARK: - Layout
    
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
    
    
//    MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupButtons()
        setupToHideKeyboardOnTapOnView()
        layout()
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
                
        let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("delete", comment: "")) {_,_,_ in

            self.delegate?.deleteTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])

        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let restart = UIContextualAction(style: .normal, title: "") {action, view, completionHandler in
            self.delegate?.restartTask(index: indexPath.row)
            completionHandler(true)

        }
        restart.backgroundColor = mainColorTheme
        restart.image = UIImage(systemName: "play.fill")
        
        
        let swipeActions = UISwipeActionsConfiguration(actions: [restart])

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
