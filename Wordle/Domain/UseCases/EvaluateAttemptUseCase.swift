//
//  EvaluateAttemptUseCase.swift
//  Wordle
//
//  Created by Popov Alexsandr on 15.06.2026.
//

import Foundation

protocol EvaluateAttemptUseCaseProtocol {
    func execute(guess: String, target: String) -> [LetterResult]
}

final class EvaluateAttemptUseCase: EvaluateAttemptUseCaseProtocol {
    func execute(guess: String, target: String) -> [LetterResult] {
        let targetArray = Array(target)
        let guessArray = Array(guess)
        
        var result = Array(repeating: LetterResult(letter: " ", status: .notInWord), count: guess.count)
        
        var targetLettersCounter: [Character: Int] = [:]
        for letter in target {
            targetLettersCounter[letter, default: 0] += 1
        }
        
        for (index, letter) in guessArray.enumerated() {
            if guessArray[index] == targetArray[index] {
                result[index] = LetterResult(letter: letter, status: .correctPosition)
                targetLettersCounter[letter, default: 0] -= 1
            }
        }
        
        for (index, letter) in guessArray.enumerated() {
            guard result[index].status != .correctPosition else { continue }
            
            if targetArray.contains(letter) {
                let counter = targetLettersCounter[letter] ?? 0
                if counter > 0 {
                    result[index] = LetterResult(letter: letter, status: .wrongPosition)
                    targetLettersCounter[letter, default: 0] -= 1
                } else {
                    result[index] = LetterResult(letter: letter, status: .notInWord)
                    targetLettersCounter[letter, default: 0] -= 1
                }
            } else {
                result[index] = LetterResult(letter: letter, status: .notInWord)
                targetLettersCounter[letter, default: 0] -= 1
            }
        }
        
        return result
    }
}
