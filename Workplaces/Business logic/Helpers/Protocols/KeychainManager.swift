//
//  KeychainManager.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 06.06.2021.
//

public protocol KeychainManager {
    
    /// Сохранение токена с защитой паролем.
    /// - Parameters:
    ///   - token: Токен.
    ///   - password: Пароль.
    /// - Returns: Возвращает `true` в случае успешного сохранения и `false` в случае неудачи.
    func saveTokenWithPassword(token: String, password: String) -> Bool
    
    /// Получение защищённого паролем токена.
    /// - Parameter password: Пароль.
    /// - Returns: В случае успешного получения возвращается токен, в противном случае - `nil`.
    func getTokenWithPassword(_ password: String) -> String?
    
    /// Сохранение токена с защитой биометрией.
    /// - Parameter token: Токен.
    /// - Returns: Возвращает `true` в случае успешного сохранения и `false` в случае неудачи.
    func saveTokenWithBiometry(token: String) -> Bool
    
    /// Получение защищённого биометрией токена.
    /// - Parameter completion: Обработчик завершения, в который в случае успешного получения возвращается токен, в противном случае - `nil`.
    func getTokenWithBiometry(completion: @escaping (String?) -> Void)
    
    /// Удаление сохранённого токена.
    func removeToken()
}
