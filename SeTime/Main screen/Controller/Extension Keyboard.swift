//
//  Extension Keyboard.swift
//  SeTime
//
//  Created by Рамиль Гирфанов on 22.06.2022.
//

import UIKit

//  MARK: - Расширение для клавиатуры что бы она скрывалась по нажанию на return

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

//  MARK: - Расширение для клавиатуры что бы она скрывалась по нажанию на любое место экрана

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

