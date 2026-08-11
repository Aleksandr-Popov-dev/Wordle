//
//  StatisticsRepositoryProtocol.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import Foundation

protocol StatisticsRepositoryProtocol {
    func saveGameResult(game: Game) async throws
    
    func getStatisticsSummary() async throws -> GameStatisticsSummary
    
    func getAllGames() async throws -> [GameStatistics]
    
    // for tests
    func clearAll() async throws
}
