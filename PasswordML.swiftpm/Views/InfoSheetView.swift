//
//  InfoSheetView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 08.04.2023.
//

import SwiftUI

/// View used as a sheet, that displays information about this app.
struct InfoSheetView: View {
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        VStack {
            LogoView()
            VStack {
                Text("Welcome to")
                Text("PasswordML")
                    .bold()
            }
            .font(.title)
            .padding(30)
            Text("""
                PasswordML is a tool and an educational app, which helps you learn how to create strong passwords. It uses a Machine Learning model to estimate password strength.
                
                Read the articles and solve the quizes to become a password master.
                
                The ML model may be inaccurate. PasswordML does not store your passwords permanently.
                """)
                .padding(30)
            
            Button("Get started",
               action: { isShowingSheet.toggle() })
        }
    }
}

struct InfoSheetView_Previews: PreviewProvider {
    static var previews: some View {
        InfoSheetView(isShowingSheet: .constant(false))
    }
}
