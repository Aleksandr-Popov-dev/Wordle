//
//  KeyboardView.swift
//  Wordle
//
//  Created by Popov Alexsandr on 22.06.2026.
//

import SwiftUI

struct KeyboardView: View {
    private let firstRow = ["й", "ц", "у", "к", "е", "н", "г", "ш", "щ", "з", "х", "ъ"]
    private let secondRow = ["ф", "ы", "в", "а", "п", "р", "о", "л", "д", "ж", "э"]
    private let thirdRow = ["я", "ч", "с", "м", "и", "т", "ь", "б", "ю"]

    private let columnsFirstRow = Array(repeating: GridItem(.flexible(), spacing: 5), count: 12)
    private let columnsSecondRow = Array(repeating: GridItem(.flexible(), spacing: 5), count: 11)
    private let columnsThirdRow = Array(repeating: GridItem(.flexible(), spacing: 5), count: 9)
    
    private var extendedThirdRow: [GridItem] {
        var colums: [GridItem] = []
        colums.append(GridItem(.fixed(50), spacing: 5))
        colums.append(contentsOf: columnsThirdRow)
        colums.append(GridItem(.fixed(80), spacing: 5))
        return colums
    }
    
    let keyStates: [String: LetterStatus]
    let onLetterTap: (String) -> Void
    let submitGuess: () -> Void
    let removeLetter: () -> Void
    var body: some View {
        VStack {
            RowView(
                columns: columnsFirstRow,
                row: firstRow,
                keyStates: keyStates,
                onLetterTap: onLetterTap
            )
            RowView(
                columns: columnsSecondRow,
                row: secondRow,
                keyStates: keyStates,
                onLetterTap: onLetterTap
            )
            RowView(
                columns: extendedThirdRow,
                row: thirdRow,
                keyStates: keyStates,
                onLetterTap: onLetterTap,
                submitGuess: submitGuess,
                removeLetter: removeLetter
            )
        }
    }
}
