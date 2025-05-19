//
//  ResultView.swift
//  Zubri
//
//  Created by Павел Сивак on 13/05/2025.
//

import SwiftUI
import CoreData

struct ResultView: View {
    
    @StateObject private var viewModel = ResultViewModel(context: PersistenceController.shared.container.viewContext)
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: GameResult.entity(), sortDescriptors: []) var results: FetchedResults<GameResult>
    
    var body: some View {
        ZStack {
            Color("backgroundMainColor")
                .ignoresSafeArea()
            
            List {
                ForEach(results) { result in
                    ResultCell(result: result)
                    .onAppear {
                        print(result)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.deleteResult(result)
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .tint(Color.red)
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }.listStyle(.plain)
        }
    }
}

#Preview {
    ResultView()
}
