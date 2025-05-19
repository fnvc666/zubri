//
//  SettingsView.swift
//  Zubri
//
//  Created by Павел Сивак on 10/05/2025.
//

import SwiftUI

struct SettingsView: View {

    @AppStorage("userName") private var userName = ""
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(entity: GameResult.entity(), sortDescriptors: []) private var results: FetchedResults<GameResult>
    @StateObject private var viewModel =
        SettingsViewModel(context: PersistenceController.shared.container.viewContext)
    
    @FocusState private var isNameFocused: Bool
    
    var body: some View {
        ZStack {
            Color("backgroundMainColor").ignoresSafeArea()
            
            VStack {
                header
                
                VStack(spacing: 30) {
                    nameRow
                    
                    if viewModel.showNameWarning {
                        Text("Name must be 10 characters or fewer.")
                            .foregroundColor(.red)
                            .font(.caption)
                            .transition(.opacity)
                    }
                    
                    Spacer()
                    followUpdatesRow
                    resetRow
                    contactRow
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 700)
                .background(Color(red: 0.95, green: 1, blue: 0.93))
                .clipShape(.rect(topLeadingRadius: 24, topTrailingRadius: 24))
            }
            .alert("Contact us", isPresented: $viewModel.showContactUsAlert) {
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Email: support@zubri.com")
            }
            .alert("Reset Application", isPresented: $viewModel.showResetAppAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Reset", role: .destructive) {
                    viewModel.resetApp(
                        results: results,
                        clearName: { userName = "" },
                        clearOnboarding: { hasSeenOnboarding = false }
                    )
                }
            } message: {
                Text("Are you sure? The process will not be undone.")
            }
        }
    }
    
    private var header: some View {
        HStack {
            Text("Settings")
                .font(.custom("Hanken Grotesk", size: 40).weight(.semibold))
                .padding(.leading, 30)
            Spacer()
            Image("settingsZubr")
                .resizable().scaledToFit().frame(width: 128, height: 128)
        }
    }
    
    private var nameRow: some View {
        HStack {
            TextField("Name",
                      text: Binding(
                          get: { userName },
                          set: { viewModel.updateUserName($0, setName: { userName = $0 }) }
                      )
            )
            .font(.custom("Hanken Grotesk", size: 24))
            .foregroundColor(viewModel.nameTextColor)
            .padding()
            .disabled(viewModel.textFieldLocked)
            .focused($isNameFocused)
            .submitLabel(.done)
            .onSubmit {
                viewModel.validateName(currentName: userName)
                if !userName.isEmpty { isNameFocused = false }
            }
            
            Spacer()
            
            Button {
                viewModel.textFieldLocked = false
                isNameFocused = true
            } label: {
                Image(systemName: "pencil")
                    .resizable().scaledToFit()
                    .frame(width: 25, height: 25)
                    .tint(.black)
            }
            .padding()
        }
        .frame(width: 350, height: 70)
        .background(Color("backgroundMainColor"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(.top, 50)
    }
    
    private var followUpdatesRow: some View {
        HStack {
            Text("Follow the updates")
                .font(.custom("Hanken Grotesk", size: 24))
                .padding()
            Spacer()
            Toggle("", isOn: $viewModel.isOn)
                .frame(width: 40, height: 30)
                .padding()
        }
        .frame(width: 350, height: 70)
        .background(Color("backgroundMainColor"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var resetRow: some View {
        HStack {
            Text("Reset App")
                .font(.custom("Hanken Grotesk", size: 24))
                .padding()
            Spacer()
            Button {
                viewModel.showResetAppAlert = true
            } label: {
                Image(systemName: "arrow.trianglehead.clockwise")
                    .resizable().scaledToFit().frame(width: 25)
                    .tint(.black)
            }
            .padding()
        }
        .frame(width: 350, height: 70)
        .background(Color("backgroundMainColor"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var contactRow: some View {
        HStack {
            Text("Contact ZUBRI")
                .font(.custom("Hanken Grotesk", size: 24))
                .padding()
            Spacer()
            Button {
                viewModel.showContactUsAlert.toggle()
            } label: {
                Image(systemName: "archivebox")
                    .resizable().scaledToFit().frame(width: 25)
                    .tint(.black)
            }
            .padding()
        }
        .frame(width: 350, height: 70)
        .background(Color("backgroundMainColor"))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
