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


//    MARK: - Notification center для приподнития ScrollView при вызове клавиатуры

extension ViewController {
        
    var nc: NotificationCenter { NotificationCenter.default }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            
            nc.addObserver(self, selector: #selector(kbShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            nc.addObserver(self, selector: #selector(kbHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        @objc private func kbShow(notification: NSNotification) {
            if let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                scrollView.contentInset.bottom = kbSize.height
                scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.height, right: 0)
            }
        }
        
        @objc private func kbHide() {
            scrollView.contentInset = .zero
            scrollView.verticalScrollIndicatorInsets = .zero
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
}
