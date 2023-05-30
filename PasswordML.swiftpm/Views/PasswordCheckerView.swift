//
//  PasswordCheckerView.swift
//  PasswordML
//
//  Created by Cristian Mihai Dinca on 05.04.2023.
//

import SwiftUI
import CoreML

struct PasswordCheckerView: View {
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    
    @State var passwordModel: PasswordModel
    
    
    @State private var password = ""
    @State private var output: Double = 0
    @State private var animationAmount: Int = 0
    let gradient = Gradient(colors: [.cyan, .blue, .purple, .orange, .pink, .red])
    @State private var animateBrain = false
    @State private var showPassword = false
    
    // Chart Data
    @State private var change: Int = 0
    @State private var passwordHistory: [PasswordData] = []
    @State var showChart: Bool = false
    
    func calculate(password: String) {
        output = passwordModel.calculate(password: password)
        passwordHistory.append(PasswordData(change: change, strength: Int(output*100), password: password))
        change = change + 1
    }
    
    
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            VStack {
                LogoView()
                .padding()
                Text("PasswordML")
                    .font(.largeTitle.bold())
                    .padding()
                Text("Type a password to check how secure it is.")
                    .multilineTextAlignment(.center)
                    .font(.body.monospaced())
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            Spacer()
            
            VStack {
                HStack {
                    ZStack {
                        if !showPassword {
                            SecureField("Enter password", text: $password)
                                .padding()
                        }
                        TextField("Enter password", text: $password)
                            .opacity(showPassword ? 1 : 0)
                            .animation(.easeInOut(duration: 2), value: password)
                            .padding()
                        
                    }
                    .onChange(of: password) { newValue in
                        withAnimation {
                            
                            calculate(password: newValue)
                            
                        }
                    }
                    Button {
                        withAnimation(.easeInOut) {
                            showPassword.toggle()
                        }
                    } label: {
                        Image(systemName: (showPassword ? "eye.slash" : "eye"))
                    }
                    .padding()
                }
                HStack {
                    Text("Security:")
                        .font(.body.bold())
                        .padding()
                    Spacer()
                    ScoreGaugeView(value: $output)
                }
                Button("Show chart") {
                    showChart = true
                }
            }
            
            .padding()
            .frame(maxWidth: 500)
            
            Spacer()
            Spacer()

            HStack {
                Spacer()
            }
        }
        .padding()
        .background((colorScheme == .light ? Color.light : Color.dark))
        .sheet(isPresented: $showChart) {
            VStack {
                HStack {
                    Text("Chart Data")
                        .bold()
                    Spacer()
                    Button("Clear Data") {
                        passwordHistory = []
                        change = 0
                    }
                    .padding(.horizontal)
                    .tint(.blue)
                    Button {
                        showChart = false
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                    }

                }
                if passwordHistory.count != 0 {
                    PassChartView(data: $passwordHistory)
                } else {
                    Spacer()
                    Text("No Data")
                        .font(.title.bold())
                        .padding()
                    Text("Type a password to see how it's strength variates with each modification.")
                        .font(.body.monospaced())
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            }
            .padding()
            .preferredColorScheme(.dark)
            .presentationDetents([.medium, .large])
        }
    }
}

struct PasswordCheckerView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordCheckerView(passwordModel: PasswordModel())
    }
}
