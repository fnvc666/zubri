//
//  Onboarding4View.swift
//  ZUBRI
//
//  Created by Павел Сивак on 08/04/2025.
//

import SwiftUI

struct Onboarding4View: View {
    
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding = false
    @AppStorage("userName") private var userName = ""
    @State private var titleOpacity: Double = 0
    @State private var imageOpacity: Double = 0
    @State private var additionalTextOpacity: Double = 0
    @State private var buttonOpacity: Double = 0
    @State private var dontWorryTextOpacity: Double = 0
    @State private var backgroundColorButton: Color = .gray
    @State private var textFieldColor: Color = .black
    
    var body: some View {
        ZStack {
            Color("backgroundMainColor")
                .ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    Spacer()
                    
                    Image("zubrGreeting")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 280)
                        .opacity(imageOpacity)
                        .animation(.easeIn(duration: 1.5), value: imageOpacity)
                    
                    Text("Hey there! \nWhat’s your name?")
                        .font(
                            Font.custom("Hanken Grotesk", size: 32)
                                .weight(.semibold)
                        )
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .kerning(-1)
                        .opacity(titleOpacity)
                        .animation(.easeIn(duration: 1.5), value: titleOpacity)
                    
                    TextField("", text: $userName)
                        .frame(width: 310, height: 60)
                        .padding(.leading, 20)
                        .autocorrectionDisabled(true)
                        .font(
                            Font.custom("Hanken Grotesk", size: 24)
                                .weight(.regular)
                        )
                        .foregroundStyle(textFieldColor)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                        .opacity(additionalTextOpacity)
                        .animation(.easeIn(duration: 1.5), value: additionalTextOpacity)
                    
                    Button {
                        hasSeenOnboarding = true
                    } label: {
                        Text("Start")
                            .font(
                                Font.custom("Hanken Grotesk", size: 20)
                                    .weight(.bold)
                            )
                            .frame(maxWidth: .infinity)
                            .frame(width: 310, height: 60)
                            .background(backgroundColorButton)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .foregroundStyle(.white)
                            .textInputAutocapitalization(.characters)
                            .opacity(buttonOpacity)
                            .animation(.easeIn(duration: 1.5), value: buttonOpacity)
                    }
                    .padding(.top, 40)
                    .disabled(userName.isEmpty)
                    
                    Text("Don’t worry, you can change it later")
                        .font(
                            Font.custom("Hanken Grotesk", size: 16)
                                .weight(.regular)
                        )
                        .kerning(-1.0)
                        .opacity(dontWorryTextOpacity)
                        .animation(.easeIn(duration: 1.5), value: dontWorryTextOpacity)

                }
                .padding(.bottom, 64)
                .padding(.horizontal, 20)
            }
            .scrollIndicators(.hidden)
        }
        .onAppear {
            imageOpacity = 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                titleOpacity = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                additionalTextOpacity = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                buttonOpacity = 1
                dontWorryTextOpacity = 1
            }
        }
        .onChange(of: userName) {newValue, prValue in
            if !userName.isEmpty && userName.count < 10 {
                textFieldColor = .black
                backgroundColorButton = Color("buttonMainColor")
            } else {
                backgroundColorButton = .gray
                textFieldColor = .red
            }
        }
    }
}

#Preview {
    Onboarding4View()
}
