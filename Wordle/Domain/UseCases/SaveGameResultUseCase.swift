//
//  SaveGameResultUseCase.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import Foundation

protocol SaveGameResultUseCaseProtocol {
    func execute(game: Game) async throws
}

final class SaveGameResultUseCase: SaveGameResultUseCaseProtocol {
    private let statisticsRepository: StatisticsRepositoryProtocol
    
    init(statisticsRepository: StatisticsRepositoryProtocol) {
        self.statisticsRepository = statisticsRepository
    }
    
    func execute(game: Game) async throws {
        try await statisticsRepository.saveGameResult(game: game)
    }
}
