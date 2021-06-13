//
//  UIView+Extension.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 15.05.2021.
//

import UIKit

extension UIView {
    
    // MARK: - Adding subview
    
    /// Добавляет сабвью с полным перекрытием родительского вью.
    /// - Parameters:
    ///   - subview: Сабвью.
    func addFulloverSubview(_ subview: UIView) {
        addSubview(subview)
        subview.fillToSuperview()
    }
    
    // MARK: - View setup
    
    /// Заполняет родительское вью (устанавливает нулевые констрейнты по всем сторонам).
    func fillToSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
    
    /// Устанавливает переданный радиус скругления углов.
    /// - Parameter value: Значение радиуса.
    func setCornerRadius(_ value: CGFloat) {
        layer.cornerCurve = .continuous
        layer.cornerRadius = value
        clipsToBounds = true
    }
    
    /// Делает вью видимым, но прозрачным.
    func showTransparent() {
        alpha = 0
        isHidden = false
    }
    
    // MARK: - Animations
    
    /// Анимация уменьшения размера.
    /// - Parameters:
    ///   - duration: Длительность анимации.
    ///   - scale: Коэффициент масштабирования.
    func downscaleAnimation(duration: TimeInterval, scale: CGFloat) {
        UIView.animate(withDuration: duration, delay: 0, options: []) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    /// Анимация восстановления исходного размера.
    /// - Parameter duration: Длительность анимации.
    func resetScaleAnimation(duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: []) {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    /// Анимация горизонтальной тряски.
    /// - Parameter duration: Длительность анимации (по умолчанию равна `0.5`).
    func shakeAnimation(duration: TimeInterval = 0.5) {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shakeAnimation.values = [0, 10, -10, 10, -5, 5, -5, 0]
        shakeAnimation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.8, 1]
        shakeAnimation.duration = duration
        shakeAnimation.isAdditive = true
        layer.add(shakeAnimation, forKey: "shake")
    }
    
    /// Анимация кнопки лайка.
    /// - Parameters:
    ///   - duration: Длительность анимации (по умолчанию равна `0.08`).
    ///   - scale: Коэффициент масштабирования (по умолчанию равен `1.3`).
    ///   - completion: Блок, выполняемый после окончания анимации.
    func likeAnimation(duration: TimeInterval = 0.08, scale: CGFloat = 1.3, completion: VoidBlock? = nil) {
        UIView.animate(withDuration: duration, delay: 0, options: [.autoreverse, .curveLinear]) {
            self.transform = CGAffineTransform(scaleX: scale, y: scale)
        } completion: { _ in
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
            completion?()
        }
    }
    
    /// Анимация плавного появления.
    /// - Parameters:
    ///   - fromValue: Изначальное значение параметра `alpha` (по умолчанию равно `0`).
    ///   - toValue: Конечное значение параметра `alpha` (по умолчанию равно `1`).
    ///   - duration: Длительность анимации (по умолчанию равна `0.4`).
    ///   - completion: Блок, выполняемый после окончания анимации.
    func appear(fromValue: CGFloat = 0, toValue: CGFloat = 1, duration: Double = 0.4, completion: VoidBlock? = nil) {
        isHidden = false
        alpha = fromValue
        UIView.animate(withDuration: duration) {
            self.alpha = toValue
        } completion: { isEnded in
            if isEnded {
                self.alpha = toValue
                completion?()
            }
        }
    }
    
    /// Анимация плавного исчезновения.
    /// - Parameters:
    ///   - fromValue: Изначальное значение параметра `alpha` (по умолчанию равно `1`).
    ///   - toValue: Конечное значение параметра `alpha` (по умолчанию равно `0`).
    ///   - duration: Длительность анимации (по умолчанию равна `0.4`).
    ///   - completion: Блок, выполняемый после окончания анимации.
    func disappear(fromValue: CGFloat = 1, toValue: CGFloat = 0, duration: Double = 0.4, completion: VoidBlock? = nil) {
        alpha = fromValue
        UIView.animate(withDuration: duration) {
            self.alpha = toValue
        } completion: { isEnded in
            if isEnded {
                self.alpha = toValue
                self.isHidden = true
                completion?()
            }
        }
    }
}
