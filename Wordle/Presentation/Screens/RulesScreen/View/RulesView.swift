//
//  RulesView.swift
//  Wordle
//
//  Created by Popov Alexsandr on 23.06.2026.
//

import SwiftUI

struct RulesView: View {
    @Binding var path: NavigationPath
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Header(path: $path, title: "Правила")
                info
                Spacer()
            }
            .foregroundStyle(.white)
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
    }
}

extension RulesView {
    var info: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(" • Пользователю загадывается одно пятибуквенное слово. У вас есть ровно шесть попыток, чтобы его угадать.\n • Ваша цель — найти правильное слово за минимальное число ходов, основываясь на расположении букв.")
                .font(.title3)
            ColorsInfo(colors: [.appGreen1, .appGreen2], label: "Буква есть в загаданном слове и стоит на своем месте")
            ColorsInfo(colors: [.appOrange1, .appOrange2], label: "Буква есть в загаданном слове, но стоит не на своем месте")
            ColorsInfo(colors: [.appDarkGray], label: "Буквы нет в заганном слове")
        }
    }
}

struct ColorsInfo: View {
    let colors: [Color]
    let label: String
    
    var body: some View {
        HStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 8)
                .fill(LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom))
                .frame(width: 45, height: 60)
            Text(label)
                .foregroundStyle(.white)
                .font(.title3)
        }
    }
}

