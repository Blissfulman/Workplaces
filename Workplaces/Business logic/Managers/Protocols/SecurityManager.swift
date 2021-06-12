//
//  SecurityManager.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 07.06.2021.
//

protocol SecurityManager: AnyObject {
    
    /// Логическое значение, определяющее, сохранён ли refresh в хранилище.
    var isSavedRefreshToken: Bool { get }
    
    /// Логическое значение, определяющее, сохранён ли пароль в хранилище.
    var isSavedPassword: Bool { get }
    
    /// Логическое значение, определяющее, авторизован ли пользователь.
    ///
    /// Устанавливается в `true` если пользователем была пройдена авторизация и были получены токены.
    /// При завершении сессии устанавливается в `false`.
    var isAuthorized: Bool { get set }
    
    /// Refresh токен.
    var refreshToken: String? { get set }
    
    /// Access токен.
    var accessToken: String? { get set }
    
    /// Пароль, используемый при последнем сохранении/чтении refresh токена.
    ///
    /// Хранение пароля необходимо для реализации фонового обновления токенов.
    var password: String { get set }
    
    /// Оставшееся количество попыток входа.
    ///
    /// Если значение достигает нуля, необходимо выполнить выход из сессии.
    /// Значение должно сохраняться между запусками приложения.
    var remainingEntryAttemptsCount: Int { get set }
    
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
    
    /// Сохранение пароля с защитой биометрией.
    /// - Parameter password: Пароль.
    /// - Returns: Возвращает `true` в случае успешного сохранения и `false` в случае неудачи.
    func savePasswordWithBiometry(password: String) -> Bool
    
    /// Получение защищённого биометрией пароля.
    /// - Parameter completion: Обработчик завершения, в который в случае успешного получения возвращается пароль, в противном случае - `nil`.
    func getPasswordWithBiometry(completion: @escaping (String?) -> Void)
    
    /// Сброс (удаление) всех данных, необходимое при завершении сессии.
    func logoutReset()
}
