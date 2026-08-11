//
//  StatisticsView.swift
//  Wordle
//
//  Created by Popov Alexsandr on 23.06.2026.
//

import SwiftUI

struct StatisticsView: View {
    @StateObject private var viewModel: StatisticsViewModel
    @Binding var path: NavigationPath
    
    init(viewModel: StatisticsViewModel, path: Binding<NavigationPath>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._path = path
    }
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea(.all)
            VStack {
                Header(path: $path, title: "Статистика")
                Spacer()
                generalStats
                Spacer()
                distributionAttempts
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden()
        }
        .alert("Ошибка", isPresented: $viewModel.showError) {
            Button("ОК") { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

extension StatisticsView {
    var generalStats: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                boxInfo(label: "Сыграно игр", value: viewModel.totalGames)
                boxInfo(label: "Выиграно игр", value: viewModel.winGames)
            }
            HStack(spacing: 10) {
                boxInfo(label: "% Побед", value: viewModel.winRate)
                boxInfo(label: "Лучшая попытка", value: viewModel.betterAttempt)
            }
        }
    }
}


extension StatisticsView {
    @ViewBuilder
    func boxInfo(label: String, value: Int) -> some View {
        VStack {
            Text(label)
                .font(.system(size: 20))
            Text("\(value)")
                .font(.system(size: 40, weight: .semibold))
        }
        .foregroundStyle(.white)
        .frame(width: 180, height: 100)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 2)
        )
    }
}


extension StatisticsView {
    var distributionAttempts: some View {
        VStack(alignment: .leading) {
            Text("Распределение попыток")
                .font(.system(size: 25))
            ForEach(1...6, id: \.self) { attempt in
                HStack {
                    Text("#\(attempt)")
                        .font(.system(size: 20))
                    Spacer()
                    ProgressBar(percentWidth: viewModel.percentWidth[attempt] ?? 0)
                    Spacer()
                    Text("\(viewModel.attemptsDistribution[attempt] ?? 0)")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                }
                
            }
        }
        .foregroundStyle(.white)
    }
}

