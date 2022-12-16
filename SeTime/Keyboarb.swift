//
//  Keyboarb.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 17.12.2022.
//

import UIKit

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
