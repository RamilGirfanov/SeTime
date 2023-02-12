//
//  RealmManager.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 13.11.2022.
//

import Foundation
import RealmSwift

// swiftlint:disable force_try

class RealmManager {
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveDay(day: Day) {
        try! localRealm.write {
            localRealm.add(day)
        }
    }
    
    func getTasks(date: Date) -> [Task] {
        var tasks: [Task] = []
        localRealm.objects(Day.self).filter("date == %@", date).first?.tasks.forEach { tasks.append($0) }
        return tasks
    }
    
    func updateTime(date: Date, workTime: Int, breakTime: Int, totalTime: Int) {
        guard let dayToUpdate = localRealm.objects(Day.self).filter("date == %@", date).first else {return}
        try! localRealm.write {
            dayToUpdate.workTime = workTime
            dayToUpdate.breakTime = breakTime
            dayToUpdate.totalTime = totalTime
        }
    }
    
    func addTask(date: Date, task: Task) {
        guard let dayToUpdate = localRealm.objects(Day.self).filter("date == %@", date).first else {return}
        try! localRealm.write {
            dayToUpdate.tasks.append(task)
        }
    }
    
    func updateTask(date: Date, index: Int, name: String, definition: String) {
        let taskToUpdate = localRealm.objects(Task.self).filter("date == %@", date)[index]
        try! localRealm.write {
            taskToUpdate.name = name
            taskToUpdate.definition = definition
        }
    }
    
    func updateTaskDuration(date: Date, index: Int, duration: Int) {
        let taskToUpdate = localRealm.objects(Task.self).filter("date == %@", date)[index]
        try! localRealm.write {
            taskToUpdate.duration = duration
        }
    }
    
    func deleteTask(date: Date, index: Int) {
        let taskToDelete = localRealm.objects(Task.self).filter("date == %@", date)[index]
        try! localRealm.write {
            localRealm.delete(taskToDelete)
        }
    }
    
    func getTaskList() -> [TaskList] {
        var tasks: [TaskList] = []
        localRealm.objects(TaskList.self).forEach { tasks.append($0) }
        return tasks
    }
    
    func addTaskList(task: TaskList) {
        try! localRealm.write {
            localRealm.add(task)
        }
    }
    
    func updateTaskList(index: Int, name: String, definition: String) {
        let taskListToUpdate = localRealm.objects(TaskList.self)[index]
        try! localRealm.write {
            taskListToUpdate.name = name
            taskListToUpdate.definition = definition
        }
    }
    
    func deleteTaskList(index: Int) {
        let taskListToDelete = localRealm.objects(TaskList.self)[index]
        try! localRealm.write {
            localRealm.delete(taskListToDelete)
        }
    }
    
    func updateSortTasksList(tasks: [TaskList]) {
        var newSortTaskListArray: [(name: String, definition: String)] = []
        tasks.forEach { newSortTaskListArray.append((name: $0.name, definition: $0.definition)) }
        
        var endIndex = tasks.count - 1
        repeat {
            deleteTaskList(index: endIndex)
            endIndex -= 1
        } while endIndex >= 0
        
        newSortTaskListArray.forEach {
            let taskList = TaskList()
            taskList.name = $0.name
            taskList.definition = $0.definition
            RealmManager.shared.addTaskList(task: taskList)
        }
    }
}
// swiftlint:enable force_try
