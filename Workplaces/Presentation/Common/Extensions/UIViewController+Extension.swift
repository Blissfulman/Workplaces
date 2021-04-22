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
}
