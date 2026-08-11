//
//  GameViewModel.swift
//  Wordle
//
//  Created by Popov Alexsandr on 22.06.2026.
//

import SwiftUI
import Combine

@MainActor
class GameViewModel: ObservableObject {
    // MARK: - UI States
    @Published var gridLetters: [[String?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    @Published var gridStatuses: [[LetterStatus?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    @Published var keyStates: [String: LetterStatus] = [:]
    @Published var currentRow: Int = 0
    @Published var currentIndex: Int = 0
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    
    // MARK: - Game States
    private var targetWord: String = ""
    private var attempts: Int = 0
    @Published var isGameOver: Bool = false
    @Published var game: Game?
    
    // MARK: - Dependencies
    private let validateWordUseCase: ValidateWordUseCase
    private let evaluateAttemptUseCase: EvaluateAttemptUseCase
    private let getRandomWordUseCase: GetRandomWordUseCase
    private let saveGameResultUseCase: SaveGameResultUseCase
    
    // MARK: - Init
    init(
        validateWordUseCase: ValidateWordUseCase,
        evaluateAttemptUseCase: EvaluateAttemptUseCase,
        getRandomWordUseCase: GetRandomWordUseCase,
        saveGameResultUseCase: SaveGameResultUseCase
    ) {
        self.validateWordUseCase = validateWordUseCase
        self.evaluateAttemptUseCase = evaluateAttemptUseCase
        self.getRandomWordUseCase = getRandomWordUseCase
        self.saveGameResultUseCase = saveGameResultUseCase
        Task {
            await startGame()
        }
    }
    
    // MARK: - Public Func
    func startGame() async {
        do {
            targetWord = try await getRandomWordUseCase.execute()
            gridLetters = Array(repeating: Array(repeating: nil, count: 5), count: 6)
            gridStatuses = Array(repeating: Array(repeating: nil, count: 5), count: 6)
            keyStates = [:]
            currentRow = 0
            currentIndex = 0
            errorMessage = nil
            showError = false
            attempts = 0
            isGameOver = false
            game = Game(targetWord: targetWord, attempts: 0, gameStatus: .inProgress)
        } catch {
            errorMessage = "Ошибка загрузки игры"
            showError = true
        }
    }
        
    func gameOver(gameStatus: GameStatus) async throws {
        isGameOver = true
        let gameResult = Game(
            targetWord: targetWord,
            attempts: attempts,
            gameStatus: gameStatus
        )
        game = gameResult
        try await saveGameResultUseCase.execute(game: gameResult)
    }
    
    func enterLetter(_ letter: String) {
        guard currentIndex < 5 else { return }
        gridLetters[currentRow][currentIndex] = letter
        currentIndex += 1
    }
    
    func removeLetter() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
        gridLetters[currentRow][currentIndex] = nil
    }
    
    func submitGuess() {
        guard currentIndex == 5 else {
            errorMessage = "Неверная длина слова"
            showError = true
            return
        }
        let guessWord = gridLetters[currentRow].compactMap { $0 }.joined()
        Task {
            do {
                let isValid = try await validateWordUseCase.validate(word: guessWord)
                
                guard isValid else {
                    self.errorMessage = "Слово не найдено"
                    self.showError = true
                    return
                }
                
                let lettersResult = evaluateAttemptUseCase.execute(
                    guess: guessWord,
                    target: targetWord
                )
                
                attempts += 1
                
                updateGridStatuses(lettersResult)
                
                guard guessWord != targetWord else {
                    try await gameOver(gameStatus: .won)
                    return
                }
                
                guard currentRow != 5 else {
                    try await gameOver(gameStatus: .lost)
                    return
                }
                
                currentRow += 1
                currentIndex = 0
            }
        }
    }
    
    // MARK: - Buttons func
    func startNewGame() {
        Task {
            await startGame()
        }
    }
    
    func giveUp() {
        Task {
            do {
                try await gameOver(gameStatus: .lost)
            }
        }
    }
    
    
    //MARK: - Private func
    private func updateGridStatuses(_ lettersResult: [LetterResult]) {
        for (index, result) in lettersResult.enumerated() {
            gridLetters[currentRow][index] = String(result.letter)
            gridStatuses[currentRow][index] = result.status
            
            let key = String(result.letter)
            let currentStatus = keyStates[key]
            
            if currentStatus == nil || currentStatus == .notInWord || (currentStatus == .wrongPosition && result.status == .correctPosition) {
                keyStates[key] = result.status
            }

        }
    }
}
