//
//  UIViewController+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 20.04.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(_ error: Error?, competion: VoidBlock? = nil) {
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
