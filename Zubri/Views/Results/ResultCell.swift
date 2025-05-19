//
//  ResultCell.swift
//  Zubri
//
//  Created by Павел Сивак on 16/05/2025.
//

import SwiftUI

struct ResultCell: View {
    
    let result: GameResult
    
    var body: some View {
        HStack(spacing: 10) {
            Image(result.imageName ?? "noImage")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(.leading)
            
            
            VStack(alignment: .leading, spacing: 10) {
                Text(result.subtopic ?? "Untitled")
                    .font(.custom("Hanken Grotesk", size: 18))
                
                if let date = result.date {
                    Text(date, style: .date)
                } else {
                    Text("-")
                }
            }
            .padding(.leading)
            
            Spacer()
            
            Text("\(Int(result.scoreFraction * 100))%")
                .font(.custom("Hanken Grotesk", size: 18))
                .padding(.trailing)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .background(Color(red: 0.95, green: 1, blue: 0.93))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.top, 10)
    }
}
