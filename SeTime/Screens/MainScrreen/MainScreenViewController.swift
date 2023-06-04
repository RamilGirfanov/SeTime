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
    
    // MARK: - View
    
    lazy var mainScreen: MainScreen = {
        let view = MainScreen()
        view.tasksTableView.dataSource = self
        view.tasksTableView.delegate = self
        return view
    }()
    
    // MARK: - ViewModel
    
    private var viewModel = MainScreenViewModel(model: TimeManager(day: Day()))
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        setupNC()
        checkDay()
        UNUserNotificationCenter.current().delegate = self
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
        
        mainScreen.activateStopMode()

        checkDay()
    }
    
    // Останавливает таймер задачи и переносит задачу в таблицу
    @objc private func stopTask() {
        viewModel.stopTask()
        
        mainScreen.activateStopTaskMode()
    }
    
    // Вызывает экран создания задачи
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
        
        let currentDate = viewModel.date
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
            date: viewModel.date,
            index: index
        )
    }
    
    func restartTask(index: Int) {
        // Получает Задачу из архива
        guard let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", viewModel.date).first?.tasks[index] else { return }
        
        viewModel.restartTask(duration: task.duration, taskIndex: index)
        
        mainScreen.activateRestartTaskMode(taskName: task.name, time: task.duration)
    }
}

// MARK: - AddTaskScreen Delegate

extension MainScreenVC: AddTasksProtocol {
    func addTask(name: String, definition: String) {
        viewModel.addTask(name: name, definition: definition)
        
        mainScreen.activateAddTaskMode(taskName: name)
    }
}

// MARK: - DefinitionTaskScreen Delegate

extension MainScreenVC: EditTasksProtocol {
    
    func editTask(taskIndex: Int) {
        guard let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", viewModel.date).first?.tasks[taskIndex] else { return }
        
        let editTaskVC = EditTaskScreenVC()
        editTaskVC.taskIndex = taskIndex
        editTaskVC.name = task.name
        editTaskVC.definition = task.definition
        editTaskVC.delegate = self
        present(editTaskVC, animated: true)
    }
}

// MARK: - EditTaskScreen Delegate

extension MainScreenVC: SaveTasksProtocol {
    
    func saveTask(taskIndex: Int, name: String, definition: String) {
        RealmManager.shared.updateTask(
            date: viewModel.date,
            index: taskIndex,
            name: name,
            definition: definition
        )
        mainScreen.tasksTableView.reloadData()
    }
}

// MARK: - StartTasksProtocol Delegate

extension MainScreenVC: StartTasksProtocol {
    func startTask(name: String, definition: String) {
        viewModel.addTask(name: name, definition: definition)
        mainScreen.activateAddTaskMode(taskName: name)
    }
}

// MARK: - NotificationCenter

extension MainScreenVC {
    
    static let notificationUpdateTime = Notification.Name("updateTime")
    static let notificationTaskTime = Notification.Name("taskTime")
    static let notificationSceneDidDisconnect = Notification.Name("disconnect")
    static let notificationCheckDay = Notification.Name("checkDay")
    
    func setupNC() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(stopTimers),
            name: MainScreenVC.notificationSceneDidDisconnect,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkDay),
            name: MainScreenVC.notificationCheckDay,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTime),
            name: MainScreenVC.notificationUpdateTime,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTaskTime),
            name: MainScreenVC.notificationTaskTime,
            object: nil
        )
    }
    
    @objc private func updateTime() {
        mainScreen.viewForTimeReview.workTimeDataLabel.text = viewModel.workTime
        mainScreen.viewForTimeReview.breakTimeDataLabel.text = viewModel.breakTime
        mainScreen.viewForTimeReview.totalTimeDataLabel.text = viewModel.totalTime
    }
    
    @objc private func updateTaskTime() {
        mainScreen.taskTimeDataLabel.text = viewModel.taskTime
    }
    
    @objc func stopTimers() {
        stop()
    }
    
    @objc func checkDay() {
        guard !UserDefaults.standard.bool(forKey: "workTimerIsActive"),
              !UserDefaults.standard.bool(forKey: "breakTimerIsActive")
        else {
            return
        }
        
        let currentDate = getShortDate(date: Date())
        
        if let day = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first {
            // Если день в БД есть
            viewModel.setDay(day: day)
            mainScreen.currentDay(day: day)
        } else {
            // Если дня в БД нет
            let day = Day()
            day.date = currentDate
            RealmManager.shared.saveDay(day: day)
            viewModel = MainScreenViewModel(model: TimeManager(day: day))
            
            mainScreen.newDay()
        }
    }
}

// MARK: - Уведомления

extension MainScreenVC {
    func notificationWorkTime() {
        if UserDefaults.standard.bool(forKey: "notificationWorkTolerance") {
            let content: UNMutableNotificationContent = {
                let content = UNMutableNotificationContent()
                content.title = "SeTime"
                content.body = NSLocalizedString("timeToBreak", comment: "")
                content.sound = UNNotificationSound.default
                content.badge = 1
                return content
            }()
            
            let timeInterval = Double(UserDefaults.standard.integer(forKey: "workTimeToNotice"))
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
            
            let workTimeRequest = UNNotificationRequest(identifier: "Work notification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(workTimeRequest)
        }
    }
    
    func notificationBreakTime() {
        if UserDefaults.standard.bool(forKey: "notificationBreakTolerance") {
            let content: UNMutableNotificationContent = {
                let content = UNMutableNotificationContent()
                content.title = "SeTime"
                content.body = NSLocalizedString("timeToWork", comment: "")
                content.sound = UNNotificationSound.default
                content.badge = 1
                return content
            }()
            
            let timeInterval = Double(UserDefaults.standard.integer(forKey: "breakTimeToNotice"))
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
            
            let breakTimeRequest = UNNotificationRequest(identifier: "Break notification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(breakTimeRequest)
        }
    }
    
    enum NotificationType {
        case workNotice
        case breakNotice
    }
    
    func cancelNotification(notificationType: NotificationType) {
        switch notificationType {
        case .workNotice:
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Work notification"])
        case .breakNotice:
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Break notification"])
        }
    }
}

// MARK: - UNUserNotificationCenterDelegate

extension MainScreenVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
