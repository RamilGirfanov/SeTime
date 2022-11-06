//
//  ViewController.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 30.05.2022.
//

import UIKit

class MainScreenViewController: UIViewController {

//    MARK: - Экземпляр MainScreen
    
    lazy var mainScreen: MainScreen = {
       let view = MainScreen()
        view.delegate = self
        return view
    }()
    
    
//    MARK: - Экземпляр модели
    
    lazy var model: Model = {
        let model = Model()
        model.delegate = self
        return model
    }()
    
    
//    MARK: - Жизненный цикл
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkDay()
    }
    
    
//    MARK: - Функционал для проверки дня
    
    private func oldDay(date: String) {
        
        let currentDay = archiveOfDays[date]!
        
        model.day = currentDay
        
        mainScreen.workTimeDataLabel.text = timeIntToString(time: currentDay.workTime)
        mainScreen.breakTimeDataLabel.text = timeIntToString(time: currentDay.breakTime)
        mainScreen.totalTimeDataLabel.text = timeIntToString(time: currentDay.totalTime)
        mainScreen.tasksTableView.reloadData()
    }
    
    private func newDay(date: String) {
        
//        Инициирование нового дня
        model = Model()
        lastDate = date
        
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

        if currentDate == lastDate {
            oldDay(date: currentDate)
        } else {
            newDay(date: currentDate)
        }
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
    
    
//    MARK: - Notification center для приподнития ScrollView при вызове клавиатуры

    var nc: NotificationCenter { NotificationCenter.default }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        nc.addObserver(self, selector: #selector(kbShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
//    func pauseWorkTimer() {
//        model.pauseWorkTimer()
//    }
    
//    func pauseBreakTimer() {
//        model.pauseBreakTimer()
//    }
    
    func stop() {
        model.stop()
    }
    
//    func startTaskTimer() {
//        model.startTaskTimer()
//    }
    
    func stopTaskTimer() {
        model.stopTaskTimer()
        mainScreen.tasksTableView.reloadData()
    }
    
    func tapForAddTask() {
        let taskVC = TaskScreenViewController()
//        TODO: - через делегат
        taskVC.delegate = self
//        Или через inout и свойство с наблюдателем
//        Или передать объект этого VC
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
        model.task.taskName = name
        model.task.definition = definition
        
//        Запускает таймер задачи
        model.startTaskTimer()
        model.task.startTime = getTime()
    }
}


//MARK: - Протокол делегата Model

extension MainScreenViewController: UpdateTime {
    func uptadeWorkTime(time: Int) {
        print("Рабочее время будет обновлено")
        mainScreen.workTimeDataLabel.text = timeIntToString(time: time)
        print("Рабочее время обновлено")
    }
    
    func uptadeBreakTime(time: Int) {
        mainScreen.breakTimeDataLabel.text = timeIntToString(time: time)
    }
    
    func uptadeTotalTime(time: Int) {
        mainScreen.totalTimeDataLabel.text = timeIntToString(time: time)
    }
    
    func uptadeTaskTime(time: Int) {
        mainScreen.taskTimeDataLabel.text = timeIntToString(time: time)
    }
}
