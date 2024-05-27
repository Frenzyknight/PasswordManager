//
//  ContentView.swift
//  PasswordManager
//
//  Created by Gaurav Ganju on 25/05/24.
//

import SwiftUI
import LocalAuthentication
import SwiftData
import CryptoKit

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var isSheetPresentedAdd = false
    @State var selectedItem: Credential?
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @Query private var credentials: [Credential]
    var keychainManager: KeychainManager = KeychainManager()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                if isUnlocked {
                    VStack {
                        List {
                            ForEach(credentials) { data in
                                Section {
                                    CredentialViewCell(account: data.account)
                                        .onTapGesture {
                                            self.selectedItem = data
                                        }
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .listSectionSpacing(.compact)
                        .listRowBackground(Color("background"))
                        HStack {
                            Spacer()
                            Button(action: {
                                // Action to perform when the button is tapped
                                print("Add button tapped")
                                
                                isSheetPresentedAdd = true
                            }) {
                                Image(systemName: "plus")
                                    .font(.largeTitle)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.blue)
                                    )
                                    .foregroundColor(.white)
                            }
                            .sheet(isPresented: $isSheetPresentedAdd) {
                                CredentialInput(credential: Credential(account: "", username: "", password: ""), buttonType: "Add New Account")
                                    .presentationDetents([.medium, .large])
                            }
                            .sheet(item: $selectedItem) { item in
                                CredentialDetailView(credential: item)
                                    .presentationDetents([.medium, .large])
                            }
                        }
                        .frame(width: getWidth() - 64)
                    }
                } else {
                    Text("Locked")
                }
            }
            .navigationTitle("Password Manager")
        }
        .onAppear {
            authenticate()
        }
    }
    
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your passwords."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked.toggle()
                } else {
                    print("Error unlocking")
                }
            }
        } else {
            print("No biometrics")
        }
    }
}

#Preview {
    ContentView()
}
