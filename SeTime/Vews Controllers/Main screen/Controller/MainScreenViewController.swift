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
    
    lazy var mainScreen: MainScreen = {
        let view = MainScreen()
        view.delegate = self
        return view
    }()
    
    
    //    MARK: - Экземпляр модели
    
    lazy var model = Model()
    

    //    MARK: - Функционал для проверки дня
    
    /*
    private func oldDay(date: String) {
        
        let currentDay = archiveOfDays[date]!
        
        model.day = currentDay
        
        mainScreen.workTimeDataLabel.text = timeIntToString(time: currentDay.workTime)
        mainScreen.breakTimeDataLabel.text = timeIntToString(time: currentDay.breakTime)
        mainScreen.totalTimeDataLabel.text = timeIntToString(time: currentDay.totalTime)
        mainScreen.tasksTableView.reloadData()
    }
    */
    
    private func newDay() {
        
//        Инициирование нового дня
        model = Model()
        
//        Настройка видимости кнопок "Работа", "Отдых", "Добавить задачу"
        mainScreen.workButton.isHidden = false
        mainScreen.breakButton.isHidden = true
        mainScreen.addTaskButton.isEnabled = false
        
//        Очистка экрана от данных
        mainScreen.workTimeDataLabel.text = "-"
        mainScreen.breakTimeDataLabel.text = "-"
        mainScreen.totalTimeDataLabel.text = "-"
        
        mainScreen.tasksTableView.reloadData()
    }
    
    func checkDay() {
        guard !model.workTimer.isValid && !model.breakTimer.isValid else { return }
        
        let currentDate = getDate()
        
        if (RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first) != nil {
            
            model.day = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first!
            
            mainScreen.workTimeDataLabel.text = timeIntToString(time: model.day.workTime)
            mainScreen.breakTimeDataLabel.text = timeIntToString(time: model.day.breakTime)
            mainScreen.totalTimeDataLabel.text = timeIntToString(time: model.day.totalTime)
            mainScreen.tasksTableView.reloadData()
        } else {
            newDay()
        }
    }
    
    
    //    MARK: - NotificationCenter для обновления UIView
    
    static let notificationWorkTime = Notification.Name("workTime")
    static let notificationBreakTime = Notification.Name("breakTime")
    static let notificationTotalTime = Notification.Name("totalTime")
    static let notificationTaskTime = Notification.Name("taskTime")

    private func setupNC() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateWorkTime), name: MainScreenViewController.notificationWorkTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateBreakTime), name: MainScreenViewController.notificationBreakTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTotalTime), name: MainScreenViewController.notificationTotalTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTaskTime), name: MainScreenViewController.notificationTaskTime, object: nil)
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
    
    
    /*
     //    Настройка кнопки вызова экрана истории
     
     func makeBarButtonItem(){
     lazy var barButton = UIBarButtonItem(image: UIImage(systemName: "calendar"), style: .plain, target: self, action: #selector(tap))
     
     navigationItem.leftBarButtonItem = barButton
     }
     
     @objc private func tap() {
     lazy var calendarVC = DatePickerViewController()
     calendarVC.title = "Выбор даты"
     present(calendarVC, animated: true)
     }
     */
    
    /*
     //    Notification center для приподнития ScrollView при вызове клавиатуры
     
     var ncForKeyBoard: NotificationCenter { NotificationCenter.default }
     
     override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     
     
     ncForKeyBoard.addObserver(self, selector: #selector(kbShow), name: UIResponder.keyboardWillShowNotification, object: nil)
     ncForKeyBoard.addObserver(self, selector: #selector(kbHide), name: UIResponder.keyboardWillHideNotification, object: nil)
     }
     
     @objc private func kbShow(notification: NSNotification) {
     if let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
     mainScreen.scrollView.contentInset.bottom = kbSize.height
     mainScreen.scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
     }
     }
     
     @objc private func kbHide() {
     mainScreen.scrollView.contentInset = .zero
     mainScreen.scrollView.verticalScrollIndicatorInsets = .zero
     }
     
     override func viewDidDisappear(_ animated: Bool) {
     super.viewDidDisappear(animated)
     ncForKeyBoard.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
     ncForKeyBoard.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
     }
     */
    
    
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
    
    func tapForAddTask() {
        let taskVC = TaskScreenViewController()
        taskVC.delegate = self
        present(taskVC, animated: true)
    }
    
    func getDayData() -> Day {
        return model.day
    }
}


//MARK: - Протокол делегата TaskScreen

extension MainScreenViewController: ManageTasks {
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

