//
//  CredentialInput.swift
//  PasswordManager
//
//  Created by Gaurav Ganju on 25/05/24.
//

import SwiftUI
import CustomTextField

struct CredentialInput: View {
    @State var credential: Credential
    @State var accountError = false
    @State var userError = false
    @State var passError = false
    @State var errorMsg = "This field is empty"
    @State var passVisible = false
    @State private var eyeName = "eye.slash"
    @State private var counter = 0

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    var keychainManager: KeychainManager = KeychainManager()

    var buttonType: String
    var body: some View {
        ZStack {
            Color("background2")
                .ignoresSafeArea()
            VStack {
                EGTextField(text: $credential.account)
                    .setPlaceHolderText("Account Name")
                    .setError(errorText: $errorMsg, error: $accountError)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                EGTextField(text: $credential.username)
                    .setPlaceHolderText("Username/Email")
                    .setError(errorText: $errorMsg, error: $userError)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                EGTextField(text: $credential.password)
                    .setPlaceHolderText("Password")
                    .setError(errorText: $errorMsg, error: $passError)
                    .setSecureText(true)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                
                Button(buttonType) {
                    if buttonType == "Save Account" {
                        counter += 1
                        if validate() {
                            credential.password = keychainManager.encryptData(password: credential.password)
                            print(credential.password)
                            updateData(data: credential)
                            dismiss()
                        }
                    } else {
                        if validate() {
                            print("true bro")
                            credential.password = keychainManager.encryptData(password: credential.password)
                            addData()
                            dismiss()
                        }
                    }
                }
                .bold()
                .frame(width: getWidth() - 32, height: 44)
                .foregroundColor(.white)
                .background(Color("appBlack"))
                .clipShape(RoundedRectangle(cornerRadius: 50, style: .continuous))
            }
            .onAppear {
                if credential.password.isEmpty == false {
                    credential.password = keychainManager.decryptData(data: credential.password)
                }
            }
            .onDisappear {
                if credential.password.isEmpty == false && counter == 0 {
                    credential.password = keychainManager.encryptData(password: credential.password)
                }

            }
        }
    }
    
    func validate() -> Bool {
        if credential.account.isEmpty {
            accountError.toggle()
            return false
        }
        if credential.username.isEmpty {
            userError.toggle()
            return false
        }
        if credential.password.isEmpty {
            passError.toggle()
            return false
        } else {
            return true
        }
    }
    
    func updateData(data: Credential) {
        try? context.save()
    }
    
    func addData() {
        let data = Credential(account: credential.account, username: credential.username, password: credential.password)
        context.insert(data)
    }
}

#Preview {
    CredentialInput(credential: Credential(account: "", username: "", password: ""), buttonType: "Add New Account")
}
