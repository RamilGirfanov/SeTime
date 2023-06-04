//
//  NotificationCenter.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2023.
//

import Foundation

final class NotifiCenter {
    static let shared = NotificationCenter.default
    private init() {}

    static let notificationSceneDidDisconnect = Notification.Name("disconnect")
    static let notificationUpdateTime = Notification.Name("updateTime")
    static let notificationTaskTime = Notification.Name("taskTime")
    static let notificationCheckDay = Notification.Name("checkDay")
}
