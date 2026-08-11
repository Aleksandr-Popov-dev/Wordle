//
//  WordRepository.swift
//  Wordle
//
//  Created by Popov Alexsandr on 15.06.2026.
//

import SwiftUI

final class WordRepository: WordRepositoryProtocol {
    private var guessWords: [String] = []
    private var targetsWords: [String] = []
    private var isLoading: Bool = false

    private func loadDictionary() throws {
        guard !isLoading else { return }
        self.isLoading = true
        defer { isLoading = false }
        do {
            self.guessWords = try getAllWords(from: "ForGuessWords")
            self.targetsWords = try getAllWords(from: "ForTargetWords")
        } catch {
            throw error
        }
        self.isLoading = false
    }
    
    private func getAllWords(from fileName: String) throws -> [String] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "txt") else {
            print("error in loading url dic: \(fileName)")
            throw DictionaryError.fileNotFound
        }
        
        let content = try String(contentsOf: url, encoding: .utf8)
        let words = content.split(separator: "\n").map { String($0) }
        
        return words
    }
    
    
    func validateWord(_ word: String) async throws -> Bool {
        try loadDictionary()
        return guessWords.contains(word.lowercased())
    }
    
    func getRandomWord() async throws -> String {
        try loadDictionary()
        guard let randomWord = targetsWords.randomElement() else {
            throw DictionaryError.noWordsAvailable
        }
        return randomWord
    }
}


enum DictionaryError: LocalizedError {
    case fileNotFound
    case noWordsAvailable
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Файл словаря не найден"
        case .noWordsAvailable:
            return "Словарь пуст"
        }
    }
}
