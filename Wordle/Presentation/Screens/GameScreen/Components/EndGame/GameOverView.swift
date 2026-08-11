//
//  EndGameView.swift
//  Wordle
//
//  Created by Popov Alexsandr on 23.06.2026.
//

import SwiftUI

struct GameOverView: View {
    @ObservedObject var viewModel: GameViewModel
    let game: Game
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 16) {
            VStack {
                Text(gameStatusString)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Загаданное слово:")
                        Text(game.targetWord)
                            .fontWeight(.semibold)
                    }
                    HStack {
                        Text("Количество попыток:")
                        Text("\(game.attempts)")
                            .fontWeight(.semibold)
                    }
                }
                .font(.title3)
                .frame(width: 300, height: 100)
                .background()
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .frame(width: 300)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(gameStatusColor)
                    .stroke(.white, lineWidth: 2)
            )
            
            StrokeButton(title: "Сыграть еще раз", width: 300) {
                viewModel.startNewGame()
            }
        }
    }
    
    private var gameStatusString: String {
        switch game.gameStatus {
        case .won:
            return "Победа!"
        case .lost:
            return "Поражение"
        case .inProgress:
            return ""
        }
    }
    
    private var gameStatusColor: Color {
        switch game.gameStatus {
        case .won:
            return .appGreen1
        case .lost:
            return .appRed
        case .inProgress:
            return .clear
        }
    }
}



struct GameOverButtonView: View {
    let label: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .foregroundStyle(.black)
                .font(.title2)
                .padding()
                .frame(width: 300)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(color)
                        .stroke(.black, lineWidth: 2)
                )
        }
    }
}

