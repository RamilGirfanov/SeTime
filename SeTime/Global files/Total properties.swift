//
//  Total properties.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 19.06.2022.
//

import UIKit

let mainColorTheme: UIColor = .systemYellow

let totalCornerRadius: CGFloat = 12

let totalHeightForTappedUIobjects: CGFloat = 34

let totalWidthForTasksButtons: CGFloat = 80

let totalSizeTextInButtons: CGFloat = 15

let textSize1: CGFloat = 20

let textSize2: CGFloat = 17

let textSize3: CGFloat = 15

let textSize4: CGFloat = 14


extension UIButton {
    func roundYeellowButton() {
        setTitleColor(.black, for: .normal)
        tintColor = .black
        backgroundColor = mainColorTheme
        layer.cornerRadius = totalCornerRadius
        translatesAutoresizingMaskIntoConstraints = false
    }
}

//Функция получения даты
func getDate() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    let currentDate = dateFormatter.string(from: Date())
    return currentDate
}

//Функция получения времени
func getTime() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    let currentTime = dateFormatter.string(from: Date())
    return currentTime
}

//Функция перевода числа Int в String формат "00:00:00"
func timeIntToString(time: Int) -> String {
    
    lazy var seconds = time % 60
    lazy var minutes = time / 60 % 60
    lazy var hours = time / 3600

    lazy var fullTime: [String] = []
    
    switch hours {
    case 1...9:
        fullTime.append("0\(hours)")
    case 10...24:
        fullTime.append("\(hours)")
    default:
        fullTime.append("00")
    }
    
    switch minutes {
    case 1...9:
        fullTime.append("0\(minutes)")
    case 10...59:
        fullTime.append("\(minutes)")
    default:
        fullTime.append("00")
    }
    
    switch seconds {
    case 1...9:
        fullTime.append("0\(seconds)")
    case 10...59:
        fullTime.append("\(seconds)")
    default:
        fullTime.append("00")
    }
    
    return fullTime.joined(separator: ":")
}
