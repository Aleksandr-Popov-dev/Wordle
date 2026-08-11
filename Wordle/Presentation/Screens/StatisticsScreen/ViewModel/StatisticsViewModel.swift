//
//  StatisticsViewModel.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import Foundation
import Combine

@MainActor
class StatisticsViewModel: ObservableObject {
    //MARK: - UI States
    @Published var statisticsSummary: GameStatisticsSummary?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    var totalGames: Int { statisticsSummary?.totalGames ?? 0 }
    var winGames: Int { statisticsSummary?.wins ?? 0 }
    var winRate: Int { statisticsSummary?.winRate ?? 0 }
    var attemptsDistribution: [Int : Int] { statisticsSummary?.attemptsDistribution ?? [:] }
    var betterAttempt: Int { statisticsSummary?.attemptsDistribution.keys.min() ?? 0}
    var percentWidth: [Int: Int] {
        attemptsDistribution.mapValues { value in
            Int((Double(value) / Double(winGames)) * 100)
        }
    }
    
    //MARK: - Dependencies
    private let getStatisticsSummaryUseCase: GetStatisticsSummaryUseCase
    
    //MARK: - Init
    init(
        getStatisticsSummaryUseCase: GetStatisticsSummaryUseCase
    ) {
        self.getStatisticsSummaryUseCase = getStatisticsSummaryUseCase
        Task {
            await loadStatistics()
        }
    }
    
    //MARK: - Public Methods
    func loadStatistics() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            statisticsSummary = try await getStatisticsSummaryUseCase.execute()
        } catch {
            errorMessage = "Неудалось загрузить статистику"
            showError = true
        }
    }
}
