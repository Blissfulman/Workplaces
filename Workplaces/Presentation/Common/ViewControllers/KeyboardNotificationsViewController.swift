//
//  KeyboardNotificationsViewController.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 19.05.2021.
//

import UIKit

/// Сабкласс `UIViewController`, помогающий обрабатывать события появления/скрытия клавиатуры.
class KeyboardNotificationsViewController: UIViewController {
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    // MARK: - Public methods
    
    /// Метод, вызываемый при появлении клавиатуры.
    /// - Parameter notification: Объект `Notification`, наблюдателя появления клавиатуры.
    @objc func keyboardWillShow(_ notification: Notification) {}
    
    /// Метод, вызываемый при скрытии клавиатуры.
    /// - Parameter notification: Объект `Notification`, наблюдателя скрытия клавиатуры.
    @objc func keyboardWillHide(_ notification: Notification) {}
    
    /// Метод, анимирующий констрейнты при появлении/скрытии клавиатуры.
    /// - Parameters:
    ///   - notification: Объект `Notification`, получаемый как параметр в методах `keyboardWillShow` и `keyboardWillHide`.
    ///   - animations: Блок, в который следует передать требуетмые для данной анимации новые значения констрейнтов.
    func animateWithKeyboard(notification: Notification, animations: ((_ keyboardFrame: CGRect) -> Void)?) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int,
              let curve = UIView.AnimationCurve(rawValue: curveValue) else { return }
        
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: curve
        ) {
            animations?(keyboardFrame.cgRectValue)
            self.view?.layoutIfNeeded()
        }
        animator.startAnimation()
    }
    
    // MARK: - Private methods
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
}
