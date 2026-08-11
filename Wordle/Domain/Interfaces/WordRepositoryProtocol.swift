//
//  WordRepositoryProtocol.swift
//  Wordle
//
//  Created by Popov Alexsandr on 15.06.2026.
//

import Foundation

protocol WordRepositoryProtocol {
    func validateWord(_ word: String) async throws -> Bool
    func getRandomWord() async throws -> String
}
