//
//  MainScreenVC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 16.12.2022.
//

import UIKit
import RealmSwift
import UserNotifications

final class MainScreenVC: UIViewController {
    // MARK: - ViewModel
    
    private var viewModel = MainScreenViewModel()
    
    // MARK: - View
    
    lazy var mainScreen: MainScreen = {
        let view = MainScreen()
        view.tasksTableView.dataSource = self
        view.tasksTableView.delegate = self
        return view
    }()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        setupNC()
        //        checkDay()
        //        UNUserNotificationCenter.current().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainScreen.tasksTableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setupTargets() {
        mainScreen.workButton.addTarget(self, action: #selector(startWork), for: .touchUpInside)
        mainScreen.breakButton.addTarget(self, action: #selector(startBreak), for: .touchUpInside)
        mainScreen.stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
        mainScreen.stopTaskButton.addTarget(self, action: #selector(stopTask), for: .touchUpInside)
        mainScreen.addTaskButton.addTarget(self, action: #selector(createTask), for: .touchUpInside)
    }
    
    // Запускает таймер работы, в том числе для задачи
    @objc private func startWork() {
        viewModel.startWork()
        
        // Уведоления
        notificationWorkTime()
        cancelNotification(notificationType: .breakNotice)
        
        mainScreen.activateWorkMode()
    }
    
    // Запускает таймер перерывов, в том числе для задачи
    @objc private func startBreak() {
        viewModel.startBreak()
                
        // Уведоления
        notificationBreakTime()
        cancelNotification(notificationType: .workNotice)
        
        mainScreen.activateBreakMode()
    }
    
    // Останавливает все таймеры, в том числе для задачи
    @objc private func stop() {
        viewModel.stopAll()
                
        // Уведоления
        cancelNotification(notificationType: .workNotice)
        cancelNotification(notificationType: .breakNotice)
        
        // checkDay()

    }
    
    // Останавливает таймер задачи и переносит задачу в таблицу
    @objc private func stopTask() {
        viewModel.stopTask()
    }
    
    // Вызывает экран запуска задачи
    @objc private func createTask() {
        let taskAddVC = AddTaskScreenVC()
        taskAddVC.delegate = self
        present(taskAddVC, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MainScreenVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentDate = getShortDate(date: Date())
        return RealmManager.shared.getTasks(date: currentDate).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.identifier, for: indexPath) as? TaskCell
        
        guard let tableViewCell = cell else { return UITableViewCell() }
        
        let currentDate = Model.shared.date
        let tasks = RealmManager.shared.getTasks(date: currentDate)
        
        tableViewCell.pullCell(taskData: tasks[indexPath.row])
        
        return tableViewCell
    }
}

// MARK: - UITableViewDelegate

extension MainScreenVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showTaskDifinition(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") {_, _, _ in
            self.deleteTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let restart = UIContextualAction(style: .normal, title: "") {_, _, completionHandler in
            self.restartTask(index: indexPath.row)
            completionHandler(true)
        }
        restart.backgroundColor = mainColorTheme
        restart.image = UIImage(systemName: "play.fill")
        let swipeActions = UISwipeActionsConfiguration(actions: [restart])
        return swipeActions
    }
}

// MARK: - Methods for TableView

extension MainScreenVC {
    func showTaskDifinition(index: Int) {
        let currentDate = getShortDate(date: Date())
        
        guard let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first?.tasks[index] else { return }
        
        let definitionTaskVC = DefinitionTaskScreenVC()
        definitionTaskVC.taskIndex = index
        definitionTaskVC.name = task.name
        definitionTaskVC.startTime = task.startTime
        definitionTaskVC.duration = timeIntToString(time: task.duration)
        definitionTaskVC.definition = task.definition
        definitionTaskVC.delegate = self
        present(definitionTaskVC, animated: true)
    }
    
    func deleteTask(index: Int) {
        RealmManager.shared.deleteTask(
            date: Model.shared.date,
            index: index
        )
    }
    
    func restartTask(index: Int) {
        // Получает Задачу из архива
        guard let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", Model.shared.date).first?.tasks[index] else { return }
        
        viewModel.restartTask(task: task, taskIndex: index)
                
        // Передает задачу в модель
//        Model.shared.restartTaskTimer(
//            index: index,
//            duration: task.duration
//        )
        
        mainScreen.activateRestartTaskMode(name: task.name, time: task.duration)
    }
}
