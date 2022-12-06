//
//  Total properties.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 19.06.2022.
//

import UIKit

//Цвет системы
let mainColorTheme: UIColor = .systemYellow

//Радиус всех UI объектов
let totalCornerRadius: CGFloat = 12

//Высота кнопок
let totalHeightForTappedUIobjects: CGFloat = 44

//Размеры текста
let textSize1: CGFloat = 20
let textSize2: CGFloat = 17
let textSize3: CGFloat = 15
let textSize4: CGFloat = 14

//Расширение для идентификатора ячеек
extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

//Расширение для настроек кнопок
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

//Расширение для клавиатуры что бы она скрывалась по нажанию на любое место экрана
extension UIViewController {
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//Функция получения короткого формата даты
func getShortDate(date: Date) -> Date {
    let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
    let dateNow = Calendar.current.date(from: dateComponents)
    return dateNow!
}

//Функция получения даты в строке
func getStringDate(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = NSLocalizedString("localizedDateFormatter", comment: "")
    let currentDate = dateFormatter.string(from: date)
    return currentDate
}

func timeDateToInt(date: Date) -> Int {
    let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
    let time = (dateComponents.hour ?? 0) * 3600 + (dateComponents.minute ?? 0) * 60
    return time
}

func timeToDate(time: Int) -> Date {
    let minutes = time / 60 % 60
    let hours = time / 3600

    var dateComponents = DateComponents()
    dateComponents.hour = hours
    dateComponents.minute = minutes
    
    let date = Calendar.current.date(from: dateComponents)
    return date!
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
    
    let seconds = time % 60
    let minutes = time / 60 % 60
    let hours = time / 3600

    var fullTime: [String] = []
    
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

//Функция очистки строк от переносов строк и лишних пробелов
func clearString(string: String) -> String {
    let components = string.components(separatedBy: .whitespacesAndNewlines)
    return components.filter { i in !i.isEmpty }.joined(separator: " ")
}
