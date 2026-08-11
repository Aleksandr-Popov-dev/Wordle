//
//  GetStatisticsSummary.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import Foundation

protocol GetStatisticsSummaryUseCaseProtocol {
    func execute() async throws -> GameStatisticsSummary
}

final class GetStatisticsSummaryUseCase: GetStatisticsSummaryUseCaseProtocol {
    private let statisticsRepository: StatisticsRepositoryProtocol
    
    init(statisticsRepository: StatisticsRepositoryProtocol) {
        self.statisticsRepository = statisticsRepository
    }
    
    func execute() async throws -> GameStatisticsSummary {
        return try await statisticsRepository.getStatisticsSummary()
    }
}
