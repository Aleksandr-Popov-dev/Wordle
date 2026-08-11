//
//  RowView.swift
//  Wordle
//
//  Created by Popov Alexsandr on 22.06.2026.
//

import SwiftUI

struct RowView: View {
    let columns: [GridItem]
    let row: [String]
    let keyStates: [String: LetterStatus]
    let onLetterTap: (String) -> Void
    let submitGuess: (() -> Void)?
    let removeLetter: (() -> Void)?
    
    init(
        columns: [GridItem],
        row: [String],
        keyStates: [String: LetterStatus],
        onLetterTap: @escaping (String) -> Void,
        submitGuess: (() -> Void)? = nil,
        removeLetter: (() -> Void)? = nil
    ) {
        self.columns = columns
        self.row = row
        self.keyStates = keyStates
        self.onLetterTap = onLetterTap
        self.submitGuess = submitGuess
        self.removeLetter = removeLetter
    }
    
    var body: some View {
        LazyVGrid(columns: columns) {
            if let removeLetter = removeLetter {
                let keyState = KeyState(key: "")
                LetterButtonView(keyState: keyState, image: "delete.backward") {
                    removeLetter()
                }
            }
            ForEach(row, id: \.self) { letter in
                let keyState = KeyState(key: letter, status: keyStates[letter])
                LetterButtonView(keyState: keyState, image: nil) {
                    onLetterTap(letter)
                }
            }
            if let submitGuess = submitGuess {
                let keyState = KeyState(key: "Ввести")
                LetterButtonView(keyState: keyState, image: nil) {
                    submitGuess()
                }
            }
        }
        .padding(.horizontal, 5)
    }
}
