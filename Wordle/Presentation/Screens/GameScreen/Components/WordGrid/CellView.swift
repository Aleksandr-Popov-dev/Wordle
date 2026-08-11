//
//  CellView.swift
//  Wordle
//
//  Created by Popov Alexsandr on 22.06.2026.
//

import SwiftUI

struct CellView: View {
    let letter: String?
    let status: LetterStatus?
    
    @State private var height: CGFloat = 0
    var body: some View {
        Text(letter ?? "")
            .foregroundStyle(foregroundColor)
            .font(.system(size: 30, weight: .semibold))
            .frame(width: 45, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(letterColor)
                    .stroke(.white, lineWidth: status == nil ? 2 : 0)
            )
    }
    
    private var letterColor: LinearGradient {
        switch status {
        case .correctPosition:
            return LinearGradient(colors: [.appGreen1, .appGreen2], startPoint: .top, endPoint: .bottom)
        case .wrongPosition:
            return LinearGradient(colors: [.appOrange1, .appOrange2], startPoint: .top, endPoint: .bottom)
        case .notInWord:
            return LinearGradient(colors: [.appDarkGray, .appDarkGray], startPoint: .top, endPoint: .bottom)
        case nil:
            return LinearGradient(colors: [.clear, .clear], startPoint: .top, endPoint: .bottom)

        }
    }
    
    private var foregroundColor: Color {
        switch status {
        case .correctPosition, .wrongPosition, .notInWord:
            return .black
        case nil:
            return .white
        }
    }
}
