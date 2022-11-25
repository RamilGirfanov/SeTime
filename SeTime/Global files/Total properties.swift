//
//  Total properties.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 19.06.2022.
//

import UIKit

let mainColorTheme: UIColor = .systemYellow

let totalCornerRadius: CGFloat = 12

let totalHeightForTappedUIobjects: CGFloat = 44

//let totalSizeTextInButtons: CGFloat = 15

let textSize1: CGFloat = 20

let textSize2: CGFloat = 17

let textSize3: CGFloat = 15

let textSize4: CGFloat = 14


extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIButton {
    func activeButton() {
        setTitleColor(.black, for: .normal)
        tintColor = .black
        backgroundColor = mainColorTheme
        layer.cornerRadius = totalCornerRadius
        isEnabled = true
    }
    
    func inactiveButton() {
        setTitleColor(.secondaryLabel, for: .normal)
        tintColor = .secondaryLabel
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = totalCornerRadius
        isEnabled = false
    }
}

func getShortDate(date: Date) -> Date {
    let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    let dateNow = Calendar.current.date(from: dateComponents)
    return dateNow!
}




//Функция получения даты
func getStringDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = NSLocalizedString("localizedDateFormatter", comment: "")
    let currentDate = dateFormatter.string(from: date)
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
