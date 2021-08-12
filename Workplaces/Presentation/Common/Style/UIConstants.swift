//
//  UIConstants.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 05.05.2021.
//

import UIKit

enum UIConstants {
    static let postImageCornerRadius: CGFloat = 12
    static let buttonCornerRadius: CGFloat = 14
    static let newPostImageCornerRadius: CGFloat = 14
    static let avatarCornerRadius: CGFloat = 16
    static let cellCornerRadius: CGFloat = 20
    
    // Сделал так из-за того, что на скруглённых экранах высота клавиатуры, возвращаемая NotofocationCenter,
    // не соответствует действетельной высоте, и поднимаемые при появлении клавиатуры элементы, уезжали слишком высоко
    static let defaultSpacingBetweenContentAndKeyboard: CGFloat = UIDevice.isSquareScreen() ? 16 : -16
    static let defaultLowerButtonsBottomSpacing: CGFloat = 44
    
    static let textFieldPadding = UIEdgeInsets(top: 15, left: 16, bottom: 15, right: 40)
    
    static let postTextMaxLength = 80
}
