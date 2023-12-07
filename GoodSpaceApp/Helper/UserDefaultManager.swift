//
//  UserDefaultManager.swift
//  GoodSpaceApp
//
//  Created by Bharat Shilavat on 07/12/23.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let userDefaults = UserDefaults.standard
    private let authTokenKey = "AuthToken"

    private init() {}

    func saveAuthToken(_ authToken: String) {
        userDefaults.set(authToken, forKey: authTokenKey)
        userDefaults.synchronize()
    }

    func getAuthToken() -> String? {
        return userDefaults.string(forKey: authTokenKey)
    }

    func clearAuthToken() {
        userDefaults.removeObject(forKey: authTokenKey)
        userDefaults.synchronize()
    }
}
