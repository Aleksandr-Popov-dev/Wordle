//
//  GameStatsEntity+CoreDataProperties.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import Foundation
import CoreData


//MARK: - Properties
extension GameStatsEntity {
    @nonobjc class func fetchRequest() -> NSFetchRequest<GameStatsEntity> {
        return NSFetchRequest<GameStatsEntity>(entityName: "GameStatsEntity")
    }
    
    //MARK: - Properties
    @NSManaged public var id: UUID
    @NSManaged public var targetWord: String
    @NSManaged public var attempts: Int16
    @NSManaged public var isWin: Bool
}

extension GameStatsEntity {
    static func fetchAll(in context: NSManagedObjectContext) -> [GameStatsEntity] {
        let request: NSFetchRequest<GameStatsEntity> = GameStatsEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    static func fetchStatistics(in context: NSManagedObjectContext) -> GameStatisticsSummary? {
        let games = fetchAll(in: context)
        guard !games.isEmpty else { return nil }
        
        let total = games.count
        let wins = games.filter { $0.isWin }.count
        
        var distibution: [Int: Int] = [:]
        for game in games where game.isWin {
            let attempts = Int(game.attempts)
            distibution[attempts, default: 0] += 1
        }
        
        let gameStatisticsSummary = GameStatisticsSummary(totalGames: total, wins: wins, attemptsDistribution: distibution)
        return gameStatisticsSummary
    }
}
