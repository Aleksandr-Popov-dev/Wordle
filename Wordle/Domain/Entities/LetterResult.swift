//
//  LetterStatus.swift
//  Wordle
//
//  Created by Popov Alexsandr on 15.06.2026.
//

import Foundation

struct LetterResult {
    let letter: Character
    let status: LetterStatus
}

enum LetterStatus {
    case correctPosition
    case wrongPosition
    case notInWord
}
