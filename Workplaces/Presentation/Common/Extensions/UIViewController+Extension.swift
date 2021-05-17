//
//  UIViewController+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ error: Error?) {
        DispatchQueue.main.async { [weak self] in
            LoadingView.hide()
            
            let alert = UIAlertController(title: "Ошибка",
                                          message: error?.localizedDescription,
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self?.present(alert, animated: true)
        }
    }
    
    func showAlert(_ message: String?) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Ошибка",
                                          message: message,
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self?.present(alert, animated: true)
        }
    }
    
    /// Добавление дочернего вью контроллера на текущий.
    /// - Parameter child: Добавляемый вью контроллер.
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
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
