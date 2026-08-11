//
//  GameStatistics.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import Foundation

struct GameStatistics: Codable {
    let id: UUID
    let targetWord: String
    let attempts: Int
    let isWin: Bool
    
    //MARK: - New Game
    init(targetWord: String, attempts: Int, isWin: Bool) {
        self.id = UUID()
        self.targetWord = targetWord
        self.attempts = attempts
        self.isWin = isWin
    }
    
    //MARK: - Exist Game
    init(id: UUID, targetWord: String, attempts: Int, isWin: Bool) {
        self.id = id
        self.targetWord = targetWord
        self.attempts = attempts
        self.isWin = isWin
    }
}


struct GameStatisticsSummary {
    let totalGames: Int
    let wins: Int
    let attemptsDistribution: [Int: Int]
    
    var winRate: Int {
        guard totalGames > 0 else { return 0 }
        return Int(Double(wins) / Double(totalGames) * 100)
    }
    
    func winsForAttempt(for attempt: Int) -> Int {
        return attemptsDistribution[attempt] ?? 0
    }
}
