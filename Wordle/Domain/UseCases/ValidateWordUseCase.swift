//
//  ValidateWordUseCase.swift
//  Wordle
//
//  Created by Popov Alexsandr on 15.06.2026.
//

import Foundation

protocol ValidateWordUseCaseProtocol {
    func validate(word: String) async throws -> Bool
}


final class ValidateWordUseCase: ValidateWordUseCaseProtocol {
    private let wordRepository: WordRepositoryProtocol
    
    init(wordRepository: WordRepositoryProtocol) {
        self.wordRepository = wordRepository
    }
    
    func validate(word: String) async throws -> Bool {
        let trimmedWord = word.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard trimmedWord.count == 5 else {
            return false
        }
        
        let russianLetters = CharacterSet(charactersIn: "абвгдеёжзийклмнопрстуфхцчшщъыьэюя")
        let wordCharacterSet = CharacterSet(charactersIn: trimmedWord.lowercased())
        
        guard russianLetters.isSuperset(of: wordCharacterSet) else {
            return false
        }
        
        return try await wordRepository.validateWord(trimmedWord)
    }
    
    
}
