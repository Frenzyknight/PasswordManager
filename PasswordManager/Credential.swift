//
//  Credential.swift
//  PasswordManager
//
//  Created by Gaurav Ganju on 25/05/24.
//

import Foundation
import SwiftData

@Model
class Credential {
    var account: String
    var username: String
    var password: String
    
    init(account: String, username: String, password: String) {
        self.account = account
        self.username = username
        self.password = password
    }
}
