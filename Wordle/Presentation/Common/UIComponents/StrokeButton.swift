//
//  StrokeButton.swift
//  Wordle
//
//  Created by Popov Alexsandr on 23.06.2026.
//

import SwiftUI

struct StrokeButton: View {
    let title: String
    let width: CGFloat?
    let action: () -> Void
    
    
    init(
        title: String,
        width: CGFloat? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.width = width
        self.action = action
    }
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Text(title)
                    .foregroundStyle(.white)
                    .font(.title2)
                    .frame(maxWidth: width == nil ? .infinity : width!)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.white, lineWidth: 2)
                            
                    )
                    .padding(.horizontal)
            }
        }
    }
}
