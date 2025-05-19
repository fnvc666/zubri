//
//  Onboarding3View.swift
//  ZUBRI
//
//  Created by Павел Сивак on 07/04/2025.
//

import SwiftUI

struct Onboarding3View: View {
    
    @State private var titleOpacity: Double = 0
    @State private var imageOpacity: Double = 0
    @State private var additionalTextOpacity: Double = 0
    
    var body: some View {
        ZStack {
            Color("backgroundMainColor")
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                
                Text("Type What \nYou Hear")
                    .font(
                        Font.custom("Hanken Grotesk", size: 48)
                            .weight(.semibold)
                    )
                    .kerning(-1.0)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 16)
                    .opacity(titleOpacity)
                    .animation(.easeInOut(duration: 1.5), value: titleOpacity)
                
                Image("laptop")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 240)
                    .padding()
                    .opacity(imageOpacity)
                    .animation(.easeOut(duration: 1.5), value: imageOpacity)
                
                Text("Listen and enter \nsentences from audio")
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
            titleOpacity = 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                imageOpacity += 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                additionalTextOpacity += 1
            }
        }
    }
}

#Preview {
    Onboarding3View()
}
