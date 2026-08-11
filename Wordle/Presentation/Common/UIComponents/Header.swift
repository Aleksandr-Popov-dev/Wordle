//
//  Header.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import SwiftUI

struct Header: View {
    @Binding var path: NavigationPath
    let title: String
    var body: some View {
        VStack(spacing: 10) {
            BackButton(path: $path)
            Line()
            Text(title)
                .font(.system(size: 40))
                .foregroundStyle(.white)
            Line()
        }
    }
}

struct Line: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 1)
            .foregroundStyle(.white)
    }
}

struct BackButton: View {
    @Binding var path: NavigationPath
    var body: some View {
        HStack {
            Button {
                path.removeLast()
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .padding(8)
                    .background(
                        Circle()
                            .stroke(.white, lineWidth: 2)
                    )
            }
            Spacer()
        }
    }
}
