//
//  ext NC + UNC.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 17.12.2022.
//

import Foundation
import UserNotifications

extension MainScreenVC {
    
//    MARK: - NotificationCenter для обновления UIView
    
    static let notificationUpdateTime = Notification.Name("updateTime")
    static let notificationTaskTime = Notification.Name("taskTime")
    static let notificationSceneDidDisconnect = Notification.Name("disconnect")
    static let notificationCheckDay = Notification.Name("checkDay")
    static let notificationStartTask = Notification.Name("startTask")
    
    func setupNC() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTime),
                                               name: MainScreenVC.notificationUpdateTime,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTaskTime),
                                               name: MainScreenVC.notificationTaskTime,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stopTimers),
                                               name: MainScreenVC.notificationSceneDidDisconnect,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkDay),
                                               name: MainScreenVC.notificationCheckDay,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(startTask(notification:)),
                                               name: MainScreenVC.notificationStartTask,
                                               object: nil)
    }
    
    @objc private func updateTime() {
        mainScreen.viewForTimeReview.totalTimeDataLabel.text = timeIntToString(time: Model.shared.totalTime)
        mainScreen.viewForTimeReview.workTimeDataLabel.text = timeIntToString(time: Model.shared.workTime)
        mainScreen.viewForTimeReview.breakTimeDataLabel.text = timeIntToString(time: Model.shared.breakTime)
    }
        
    @objc private func updateTaskTime() {
        mainScreen.taskTimeDataLabel.text = timeIntToString(time: Model.shared.taskTime)
    }

    @objc func stopTimers() {
        stop()
    }
    
    
    @objc func checkDay() {
        guard !Model.shared.workTimer.isValid && !Model.shared.breakTimer.isValid else { return }
        
        let currentDate = getShortDate(date: Date())
        
        if (RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first) != nil {
//            Если день в БД есть
            Model.shared.workTime = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first!.workTime
            Model.shared.breakTime = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first!.breakTime
            Model.shared.totalTime = RealmManager.shared.localRealm.objects(Day.self).filter("date == %@", currentDate).first!.totalTime
            
            mainScreen.currentDay(workTime: Model.shared.workTime, breakTime: Model.shared.breakTime, totalTime: Model.shared.totalTime)
        } else {
//          Если дня в БД нет
            let day = Day()
            day.date = currentDate
            RealmManager.shared.saveDay(day: day)
            Model.shared.reloadModel()
            
            mainScreen.newDay()
        }
    }
    
    @objc private func startTask(notification: Notification) {
        guard let task = notification.userInfo?["task"] as? TaskList else { return }
        
//        Управляет запуском и остановкой таймеров
        if Model.shared.taskTimer.isValid {
            stopTaskTimer()
        }
        
        if !Model.shared.workTimer.isValid {
            startWorkTimer()
        }
                
//        Меняет видимости кнопки и вью задачи на главном экране
        mainScreen.addTaskButton.isHidden = true
        mainScreen.taskTimerView.isHidden = false
        
//        Устанавливает в лейбл задачи ее название
        mainScreen.taskTimeTextLabel.text = task.name
        
//        Устанавливает название и описание задачи в объект задачи
        Model.shared.task.name = task.name
        Model.shared.task.definition = task.definition
        
//        Запускает таймер задачи
        Model.shared.startTaskTimer()
        Model.shared.task.startTime = getTime()
    }
    
    
//    MARK: - Уведомления о времени работы
    
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
            print(timeInterval)
            
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


//MARK: - Расширение для UNUserNotificationCenter

extension MainScreenVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
