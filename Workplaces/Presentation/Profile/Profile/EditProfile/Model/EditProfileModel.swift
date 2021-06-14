//
//  EditProfileModel.swift
//  Workplaces
//
//  Created by Evgeny Novgorodov on 14.05.2021.
//

import Foundation

final class EditProfileModel {
    
    // MARK: - Nested types
    
    struct EditingUser {
        var firstName: String
        var lastName: String
        var nickname: String
        var birthday: Date
        
        init(user: User) {
            self.firstName = user.firstName
            self.lastName = user.lastName
            self.nickname = user.nickname ?? ""
            self.birthday = user.birthday
        }
    }
    
    // MARK: - Public properties
    
    let profile: User
    var editedProfile: EditingUser
    var avatarURL: URL?
    var uploadUser: UploadUser {
        UploadUser(
            firstName: editedProfile.firstName,
            lastName: editedProfile.lastName,
            nickname: editedProfile.nickname,
            birthday: editedProfile.birthday,
            avatarFileURL: avatarURL
        )
    }
    var stringBirthday: String {
        DateFormatter.profileDateFormatter.string(from: editedProfile.birthday)
    }
    var isChangedAvatar = false
    var isPossibleToSaveProfile: Bool {
        (!hasNotBeenEditedProfile && !isEmptyAtLeastOneProperty) || isChangedAvatar
    }
    
    // MARK: - Private properties
    
    private var hasNotBeenEditedProfile: Bool {
        profile.nickname ?? "" == editedProfile.nickname
            && profile.firstName == editedProfile.firstName
            && profile.lastName == editedProfile.lastName
            && profile.birthday == editedProfile.birthday
    }
    private var isEmptyAtLeastOneProperty: Bool {
        // Поле birthday не проверяется, т.к. оно не должно получаться пустым (заполняется через DatePicker)
        editedProfile.nickname.isEmpty || editedProfile.firstName.isEmpty || editedProfile.lastName.isEmpty
    }
    
    // MARK: - Initializers
    
    init(profile: User) {
        self.profile = profile
        self.editedProfile = EditingUser(user: profile)
    }
}
