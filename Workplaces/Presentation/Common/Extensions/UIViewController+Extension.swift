//
//  UIViewController+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

extension UIViewController {
    
    /// Отображение ошибки с помощью `UIAlertController`.
    /// - Parameters:
    ///   - error: Ошибка.
    ///   - competion: Блок, выполняемый после нажатия кнопки "Ok" в открывшемся `UIAlertController`.
    func showAlert(error: Error?, competion: VoidBlock? = nil) {
        DispatchQueue.main.async { [weak self] in
            LoadingView.hide()
            
            let alert = UIAlertController(
                title: "Error".localized(),
                message: error?.localizedDescription,
                preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                competion?()
            }
            alert.addAction(okAction)
            self?.present(alert, animated: true)
        }
    }
    
    /// Отображение всплывающего окна с переданным заголовком и сообщением с помощью `UIAlertController`.
    ///
    /// Сообщение не является обязательным.
    /// - Parameters:
    ///   - title: Заголовок.
    ///   - message: Сообщение.
    ///   - competion: Блок, выполняемый после нажатия кнопки "Ok" в открывшемся `UIAlertController`.
    func showAlert(title: String, message: String? = nil, competion: VoidBlock? = nil) {
        DispatchQueue.main.async { [weak self] in
            LoadingView.hide()
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                competion?()
            }
            alert.addAction(okAction)
            self?.present(alert, animated: true)
        }
    }
    
    /// Добавление дочернего вью контроллера на текущий с полным перекрытием родительского.
    /// - Parameter child: Добавляемый вью контроллер.
    func addFullover(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.fillToSuperview()
        child.didMove(toParent: self)
    }
    
    /// Удаление указанного дочернего вью контроллера с его родительского контроллера.
    /// - Parameter child: Удаляемые вью контроллер.
    func remove(_ child: UIViewController) {
        guard parent != nil else { return }

        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
