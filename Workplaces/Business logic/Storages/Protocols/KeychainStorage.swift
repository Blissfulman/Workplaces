//
//  KeychainStorage.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 06.06.2021.
//

public protocol KeychainStorage: AnyObject {
    
    var protectionState: String? { get set }
    
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
    
    /// Сохранение пароля с защитой биометрией.
    /// - Parameter password: Пароль.
    /// - Returns: Возвращает `true` в случае успешного сохранения и `false` в случае неудачи.
    func savePasswordWithBiometry(password: String) -> Bool
    
    /// Получение защищённого биометрией пароля.
    /// - Parameter completion: Обработчик завершения, в который в случае успешного получения возвращается пароль, в противном случае - `nil`.
    func getPasswordWithBiometry(completion: @escaping (String?) -> Void)
    
    /// Удаление сохранённого токена.
    func removeToken()
}
