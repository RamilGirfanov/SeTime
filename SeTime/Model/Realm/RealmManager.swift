//
//  RealmManager.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 13.11.2022.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveDay(day: Day) {
        try! localRealm.write {
            localRealm.add(day)
        }
    }
    
//    func getDay(date: String) -> Day {
//        let day = localRealm.objects(Day.self).filter("date == \(date)").first
//        return day
//    }
    
    func updateDay(day: Day) {
        guard let dayToUpdate = localRealm.objects(Day.self).filter("date == \(day.date)").first else {return}
        try! localRealm.write {
            dayToUpdate.workTime = day.workTime
            dayToUpdate.breakTime = day.breakTime
            dayToUpdate.totalTime = day.totalTime
            dayToUpdate.tasks = day.tasks
        }
    }
}
