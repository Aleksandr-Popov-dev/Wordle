//
//  GetRandomWordUseCase.swift
//  Wordle
//
//  Created by Popov Alexsandr on 15.06.2026.
//

import Foundation

protocol GetRandomWordUseCaseProtocol {
    func execute() async throws -> String
}


final class GetRandomWordUseCase: GetRandomWordUseCaseProtocol {
    private let wordRepository: WordRepositoryProtocol
    
    init(wordRepository: WordRepositoryProtocol) {
        self.wordRepository = wordRepository
    }
    
    func execute() async throws -> String {
        // validation
        // formattors
        // cache
        return try await wordRepository.getRandomWord()
    }
    
    
}
