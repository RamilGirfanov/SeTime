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
    
    static let notificationSceneDidDisconnect = Notification.Name("disconnect")
    static let notificationTaskTableView = Notification.Name("tableView")
    static let notificationCheckDay = Notification.Name("checkDay")
    
    func setupNC() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stopTimers),
                                               name: MainScreenVC.notificationSceneDidDisconnect,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadTaskTableView),
                                               name: MainScreenVC.notificationTaskTableView,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(checkDay),
                                               name: MainScreenVC.notificationCheckDay,
                                               object: nil)
    }
    
    @objc func stopTimers() {
        stop()
    }
    
    @objc func reloadTaskTableView() {
        mainScreen.tasksTableView.reloadData()
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
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            
            let breakTimeRequest = UNNotificationRequest(identifier: "Break notification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(breakTimeRequest)
        }
    }
    
    enum NotificationType {
        case workNotice
        case breakNotice
        case allNotice
    }
    
    func cancelNotification(notificationType: NotificationType) {
        switch notificationType {
        case .workNotice:
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Work notification"])
        case .breakNotice:
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["Break notification"])
        case .allNotice:
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
    }
}


//MARK: - Расширение для UNUserNotificationCenter

extension MainScreenVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
