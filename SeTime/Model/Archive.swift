//
//  Archive.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 04.06.2022.
//

import UIKit

//В этом файле будет архив с данными каждого дня

//Словарь в котором ключ - это дата, значаение - объект типа День с данными о времени и задачах
var archiveOfDays: [Int: Day] = [:]

//Функция добавления дня в архив
func addDayToArchive(day: Day) {
    archiveOfDays[day.data!] = day
}
