//
//  LetterButtonView.swift
//  Wordle
//
//  Created by Popov Alexsandr on 22.06.2026.
//

import SwiftUI

struct LetterButtonView: View {
    let keyState: KeyState
    let image: String?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if keyState.key != "" {
                Text(keyState.key)
                    .foregroundStyle(.black)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(keyState.backgroudColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            if let image = image {
                Image(systemName: image)
                    .foregroundStyle(.black)
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(.appGray)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}
