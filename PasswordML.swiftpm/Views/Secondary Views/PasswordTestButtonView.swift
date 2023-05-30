//
//  PasswordTestButtonView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 07.04.2023.
//

import SwiftUI

/// The sidebar's button for the password strength estimator tool
struct PasswordTestButtonView: View {
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "key")
                    .font(.system(size: 30))
                .foregroundStyle(.linearGradient(Gradient(colors: [.indigo, .blue, .green]), startPoint: .leading, endPoint: .trailing))
            }
            .frame(width: 40)
            Text("Test a Password")
                .bold()
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

struct PasswordTestButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTestButtonView()
    }
}
