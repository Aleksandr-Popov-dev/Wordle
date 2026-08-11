//
//  Game.swift
//  Wordle
//
//  Created by Popov Alexsandr on 15.06.2026.
//

import Foundation

struct Game {
    let targetWord: String
    let attempts: Int
    let gameStatus: GameStatus
}

enum GameStatus {
    case won
    case lost
    case inProgress
}
