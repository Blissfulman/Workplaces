//
//  SecurityManager.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 07.06.2021.
//

public protocol SecurityManager: AnyObject {
    
    /// Состояние защиты входа приложения.
    ///
    /// Должно сохранияться между запусками работы приложения.
    var protectionState: ProtectionState { get set }
    
    /// Свойство авторизованности пользователя.
    ///
    /// Устанавливается в `true` если пользователем была пройдена авторизация и им были получены токены.
    /// При этом оно никак не отражает установил ли пользователь защиту входа паролем, либо биометрическими данными.
    /// При завершении сессии устанавливается в `false`.
    var isAuthorized: Bool { get set }
    
    /// Refresh токена.
    var refreshToken: String? { get set }
    
    /// Пароль, используемый при последнем сохранении/чтении refresh токена.
    ///
    /// Хранение пароля необходимо для реализации фонового обновления токенов.
    var password: String { get set }
    
    /// Access токен.
    var accessToken: String? { get set }
    
    /// Сохранение refresh токена с защитой паролем.
    /// - Parameters:
    ///   - token: Refresh токен.
    ///   - password: Пароль.
    /// - Returns: Возвращает `true` в случае успешного сохранения и `false` в случае неудачи.
    func saveRefreshTokenWithPassword(token: String, password: String) -> Bool
    
    /// Получение защищённого паролем refresh токена.
    /// - Parameter password: Пароль.
    /// - Returns: В случае успешного получения возвращается refresh токен, в противном случае - `nil`.
    func getRefreshTokenWithPassword(_ password: String) -> String?
    
    /// Сохранение refresh токена с защитой биометрией.
    /// - Parameter token: Refresh токен.
    /// - Returns: Возвращает `true` в случае успешного сохранения и `false` в случае неудачи.
    func saveRefreshTokenWithBiometry(token: String) -> Bool
    
    /// Получение защищённого биометрией refresh токена.
    /// - Parameter completion: Обработчик завершения, в который в случае успешного получения возвращается refresh токен, в противном случае - `nil`.
    func getRefreshTokenWithBiometry(completion: @escaping (String?) -> Void)
    
    /// Сброс (удаление) всех данных, необходимое при завершении сессии.
    func logoutReset()
}
