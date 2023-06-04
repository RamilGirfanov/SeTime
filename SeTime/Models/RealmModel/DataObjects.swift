//
//  DataObjects.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 13.11.2022.
//

import Foundation
import RealmSwift

class Task: Object {
    @Persisted var date = Date()
    @Persisted var name = ""
    @Persisted var definition = ""
    @Persisted var duration = 0
    @Persisted var startTime = ""
}

class Day: Object {
    @Persisted var date = Date()
    @Persisted var workTime = 0
    @Persisted var breakTime = 0
    @Persisted var totalTime = 0
    
    @Persisted var tasks = List<Task>()
}

class TaskList: Object {
    @Persisted var name = ""
    @Persisted var definition = ""
}
