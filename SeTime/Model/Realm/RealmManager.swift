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
    
    func updateTime(date: String, workTime: Int, breakTime: Int, totalTime: Int) {
        guard let dayToUpdate = localRealm.objects(Day.self).filter("date == %@", date).first else {return}
        try! localRealm.write {
            dayToUpdate.workTime = workTime
            dayToUpdate.breakTime = breakTime
            dayToUpdate.totalTime = totalTime
        }
    }
    
    func addTask(date: String, task: Task) {
        guard let dayToUpdate = localRealm.objects(Day.self).filter("date == %@", date).first else {return}
        try! localRealm.write{
            dayToUpdate.tasks.append(task)
        }
    }
    
    func updateTask(date: String, index: Int, name: String, definition: String) {
        let taskToUpdate = localRealm.objects(Task.self).filter("date == %@", date)[index]
        try! localRealm.write{
            taskToUpdate.name = name
            taskToUpdate.definition = definition
        }
    }
    
    func deleteTask() {
//        TODO: - Реализовать
    }
}
