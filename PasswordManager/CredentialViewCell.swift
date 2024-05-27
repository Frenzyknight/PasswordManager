//
//  CredentialView.swift
//  PasswordManager
//
//  Created by Gaurav Ganju on 25/05/24.
//

import SwiftUI

struct CredentialView: View {
    @State var account: String
    var body: some View {
        HStack {
            Text(account)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(Color.black.opacity(0.3))
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .frame(width: getWidth() - 32)
    }
}

#Preview {
    CredentialView(account: "Google")
}
