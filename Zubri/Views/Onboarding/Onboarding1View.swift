//
//  Onboarding1View.swift
//  ZUBRI
//
//  Created by Павел Сивак on 07/04/2025.
//

import SwiftUI

struct Onboarding1View: View {
    
    @State private var textOpacity: Double = 0
    @State private var imageOpacity: Double = 0
    @State private var additionalTextOpacity: Double = 0
    
    var body: some View {
        ZStack {
            Color("backgroundMainColor")
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("Improve Your \nListening Skills")
                    .font(
                        Font.custom("Hanken Grotesk", size: 48)
                            .weight(.semibold)
                    )
                    .kerning(-1.0)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(.horizontal, 16)
                    .opacity(textOpacity)
                    .animation(.easeOut(duration: 1.5), value: textOpacity)
                
                Image("girl")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 280)
                    .padding()
                    .opacity(imageOpacity)
                    .animation(.easeOut(duration: 1.5), value: imageOpacity)
                
                Text("Practise transcribing\nEnglish audio to text")
                    .font(
                        Font.custom("Hanken Grotesk", size: 24)
                            .weight(.regular)
                    )
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .opacity(additionalTextOpacity)
                    .animation(.easeOut(duration: 1.5), value: additionalTextOpacity)
                
                Spacer()
                
            }
            .padding(.bottom, 32)
        }
        .onAppear {
            textOpacity = 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                imageOpacity = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                additionalTextOpacity = 1
            }
        }
    }
}


#Preview {
    Onboarding1View()
}
