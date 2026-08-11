//
//  GameView.swift
//  Wordle
//
//  Created by Popov Alexsandr on 22.06.2026.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel: GameViewModel
    @Binding var path: NavigationPath
    
    init(viewModel: GameViewModel, path: Binding<NavigationPath>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._path = path
    }
    var body: some View {
        ZStack {
            background
            gameContent
                .blur(radius: viewModel.isGameOver ? 12 : 0)
        }
        .overlay {
            Group {
                if viewModel.isGameOver {
                    GameOverView(viewModel: viewModel, game: viewModel.game!, path: $path)
                }
            }
        }
        .alert("Ошибка", isPresented: $viewModel.showError) {
            Button("ОК") { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .navigationBarBackButtonHidden()
    }
}

extension GameView {
    var background: some View {
        Image("bg")
            .resizable()
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension GameView {
    var gameContent: some View {
        VStack {
            toolBarButtons
            Spacer()
            Text("Worlde")
                .foregroundStyle(.white)
                .font(.largeTitle)
            Spacer()
            WordGridView(viewModel: viewModel)
            Spacer()
            KeyboardView(
                keyStates: viewModel.keyStates,
                onLetterTap: { letter in
                    viewModel.enterLetter(letter)
                },
                submitGuess: viewModel.submitGuess,
                removeLetter: viewModel.removeLetter)
            Spacer().frame(height: 10)
        }
    }
}

extension GameView {
    var toolBarButtons: some View {
        HStack {
            HStack(spacing: 20) {
                Button {
                    path.append(NavigationPage.rules)
                } label: {
                    Image(systemName: "questionmark")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(.white, lineWidth: 2)
                        )
                }
                Button {
                    path.append(NavigationPage.statistics)
                } label: {
                    Image(systemName: "chart.bar")
                        .foregroundStyle(.white)
                        .font(.title)
                }
            }
            Spacer()
            Button {
                viewModel.giveUp()
            } label: {
                HStack {
                    Text("Сдаться")
                        .font(.title2)
                }
                .foregroundStyle(.white)
            }
                
        }
        .padding(.horizontal)
    }
}


