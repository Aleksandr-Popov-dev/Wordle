//
//  WordGridView.swift
//  Wordle
//
//  Created by Popov Alexsandr on 22.06.2026.
//

import SwiftUI

struct WordGridView: View {
    @ObservedObject var viewModel: GameViewModel
    var body: some View {
        VStack {
            ForEach(0..<viewModel.gridLetters.count, id: \.self) { row in
                HStack {
                    ForEach(0..<5, id: \.self) { index in
                        let letter = viewModel.gridLetters[row][index]
                        let status = viewModel.gridStatuses[row][index]
                        CellView(letter: letter, status: status)
                    }
                }
            }
        }
    }
}
