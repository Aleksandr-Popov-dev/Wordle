//
//  ProgressBar.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import SwiftUI

struct ProgressBar: View {
    let staticWidth: CGFloat = 300
    let percentWidth: Int
    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .stroke(.white, lineWidth: 2)
                .frame(width: staticWidth, height: 30)
            Capsule()
                .fill(.white)
                .frame(width: progressWidth, height: 30)
                .overlay(alignment: .trailing) {
                    Text("\(percentWidth)%")
                        .foregroundStyle(percentWidth != 0 ? .appBackground : .white)
                        .padding(.horizontal, 6)
                        .fontWeight(.semibold)
                }
        }
    }
    
    var progressWidth: CGFloat {
        if percentWidth > 9 && percentWidth < 17 {
            return 52
        } else if percentWidth <= 9 && percentWidth > 0 {
            return 40
        } else {
            return staticWidth * CGFloat(percentWidth) / 100
        }
    }
}
