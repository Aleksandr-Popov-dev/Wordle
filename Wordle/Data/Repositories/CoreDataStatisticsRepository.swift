//
//  CoreDataStatisticsRepository.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import Foundation
import CoreData

final class CoreDataStatisticsRepository: StatisticsRepositoryProtocol {
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack = .shared) {
        self.coreDataStack = coreDataStack
    }
    
    func saveGameResult(game: Game) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { context in
                do {
                    let _ = GameStatsEntity(
                        context: context,
                        targetWord: game.targetWord,
                        attempts: Int16(game.attempts),
                        isWin: game.gameStatus == .won ? true : false
                    )
                    
                    try context.save()
                    continuation.resume(returning: ())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func getStatisticsSummary() async throws -> GameStatisticsSummary {
        return try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { context in
                do {
                    guard let stats = GameStatsEntity.fetchStatistics(in: context) else {
                        continuation.resume(returning: GameStatisticsSummary(totalGames: 0, wins: 0, attemptsDistribution: [:]))
                        return
                    }
                    
                    let gameStatisticsSummary = GameStatisticsSummary(
                        totalGames: stats.totalGames,
                        wins: stats.wins,
                        attemptsDistribution: stats.attemptsDistribution
                    )
                    
                    continuation.resume(returning: gameStatisticsSummary)
                }
            }
        }
    }
    
    func getAllGames() async throws -> [GameStatistics] {
        return try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { context in
                do {
                    let entities = GameStatsEntity.fetchAll(in: context)
                    let games = entities.map { $0.toDomain() }
                    continuation.resume(returning: games)
                }
            }
        }
    }
    
    func clearAll() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            coreDataStack.performBackgroundTask { context in
                do {
                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = GameStatsEntity.fetchRequest()
                    let branchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                    try context.execute(branchDeleteRequest)
                    try context.save()
                    continuation.resume(returning: ())
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
