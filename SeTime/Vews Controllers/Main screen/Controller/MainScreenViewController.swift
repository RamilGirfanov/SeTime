//
//  ViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.05.2022.
//

import UIKit
import RealmSwift

class MainScreenViewController: UIViewController {
    
//    MARK: - Экземпляр MainScreen
    
    private lazy var mainScreen: MainScreen = {
        let view = MainScreen()
        view.delegate = self
        return view
    }()
    
    
//    MARK: - Экземпляр модели
    
    lazy var model = Model()
    

//    MARK: - Функционал для проверки дня
    
    private func checkDay() {
        guard !model.workTimer.isValid && !model.breakTimer.isValid else { return }
        
        let currentDate = getShortDate(date: Date())
        
        if (RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first) != nil {
//            Если день в БД есть
            model.workTime = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first!.workTime
            model.breakTime = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first!.breakTime
            model.totalTime = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first!.totalTime
            
            mainScreen.workTimeDataLabel.text = timeIntToString(time: model.workTime)
            mainScreen.breakTimeDataLabel.text = timeIntToString(time: model.breakTime)
            mainScreen.totalTimeDataLabel.text = timeIntToString(time: model.totalTime)
            mainScreen.tasksTableView.reloadData()
        } else {
//          Если дня в БД нет
            let day = Day()
            day.date = currentDate
            RealmManager.shared.saveDay(day: day)
            model = Model()
            
//        Настройка видимости кнопок
            mainScreen.workButton.isHidden = false
            mainScreen.breakButton.isHidden = true
            mainScreen.addTaskButton.isEnabled = false
            
//        Очистка экрана от данных
            mainScreen.workTimeDataLabel.text = "-"
            mainScreen.breakTimeDataLabel.text = "-"
            mainScreen.totalTimeDataLabel.text = "-"
            mainScreen.tasksTableView.reloadData()
        }
    }
    
    
//    MARK: - NotificationCenter для обновления UIView
    
    static let notificationWorkTime = Notification.Name("workTime")
    static let notificationBreakTime = Notification.Name("breakTime")
    static let notificationTotalTime = Notification.Name("totalTime")
    static let notificationTaskTime = Notification.Name("taskTime")
    static let notificationSceneDidDisconnect = Notification.Name("disconnect")
    static let notificationTaskTableView = Notification.Name("tableView")

    private func setupNC() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateWorkTime), name: MainScreenViewController.notificationWorkTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBreakTime), name: MainScreenViewController.notificationBreakTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTotalTime), name: MainScreenViewController.notificationTotalTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTaskTime), name: MainScreenViewController.notificationTaskTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(stopTimers), name: MainScreenViewController.notificationSceneDidDisconnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTaskTableView), name: MainScreenViewController.notificationTaskTableView, object: nil)
    }
    
    @objc private func updateWorkTime() {
        mainScreen.workTimeDataLabel.text = timeIntToString(time: model.workTime)
    }
    
    @objc private func updateBreakTime() {
        mainScreen.breakTimeDataLabel.text = timeIntToString(time: model.breakTime)
    }
    
    @objc private func updateTotalTime() {
        mainScreen.totalTimeDataLabel.text = timeIntToString(time: model.totalTime)
    }
    
    @objc private func updateTaskTime() {
        mainScreen.taskTimeDataLabel.text = timeIntToString(time: model.taskTime)
    }
    
    @objc private func stopTimers() {
        stop()
    }
    
    @objc private func reloadTaskTableView() {
        mainScreen.tasksTableView.reloadData()
    }
    
    
//    MARK: - Жизненный цикл
    
    override func loadView() {
        checkDay()
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNC()
    }
}


//MARK: - Протокол делегата MainScreen

extension MainScreenViewController: ManageTimers {
    
    func startWorkTimer() {
        model.startWorkTimer()
        
        if model.task.duration != 0 {
            model.startTaskTimer()
        }
        
        model.pauseBreakTimer()
    }
    
    func startBreakTimer() {
        model.startBreakTimer()
        model.pauseWorkTimer()
    }
    
    func stop() {
        model.stop()
    }
        
    func stopTaskTimer() {
        model.stopTaskTimer()
    }
    
    func addTask() {
        let taskAddVC = AddTaskScreenViewController()
        taskAddVC.delegate = self
        present(taskAddVC, animated: true)
    }
    
    func showTaskDifinition(index: Int) {
        
        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", model.date).first!.tasks[index]
        
        let definitionTaskVC = DefinitionTaskScreenViewController()
        definitionTaskVC.taskIndex = index
        definitionTaskVC.name = task.name
        definitionTaskVC.startTime = task.startTime
        definitionTaskVC.duration = timeIntToString(time: task.duration)
        definitionTaskVC.definition = task.definition
        definitionTaskVC.delegate = self
        present(definitionTaskVC, animated: true)
    }
    
    func getTasksData() -> [Task] {
        var tasksArray: [Task] = []
        RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", getShortDate(date: Date())).first?.tasks.forEach { tasksArray.append($0) }
        return tasksArray
    }
    
    func deleteTask(index: Int) {
        RealmManager.shared.deleteTask(date: model.date, index: index)
    }
}


//MARK: - Протокол делегата AddTaskScreen

extension MainScreenViewController: AddTasksProtocol {
    func addTask(name: String, definition: String) {
        
//        Меняет видимости кнопки и вью задачи на главном экране
        mainScreen.addTaskButton.isHidden = true
        mainScreen.taskTimerView.isHidden = false
        
//        Устанавливает в лейбл задачи ее название
        mainScreen.taskTimeTextLabel.text = name
        
//        Устанавливает название и описание задачи в объект задачи
        model.task.name = name
        model.task.definition = definition
        
//        Запускает таймер задачи
        model.startTaskTimer()
        model.task.startTime = getTime()
    }
}


//MARK: - Протокол делегата DefinitionTaskScreen

extension MainScreenViewController: EditTasksProtocol {
    func editTask(taskIndex: Int) {
        
        let task = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", model.date).first!.tasks[taskIndex]
        
        let editTaskVC = EditTaskScreenViewController()
        editTaskVC.taskIndex = taskIndex
        editTaskVC.name = task.name
        editTaskVC.definition = task.definition
        editTaskVC.delegate = self
        present(editTaskVC, animated: true)
    }
}


//MARK: - Протокол делегата EditTaskScreen

extension MainScreenViewController: SaveTasksProtocol {
    func saveTask(taskIndex: Int, name: String, definition: String) {
        RealmManager.shared.updateTask(date: model.date, index: taskIndex, name: name, definition: definition)
        mainScreen.tasksTableView.reloadData()
    }
}
