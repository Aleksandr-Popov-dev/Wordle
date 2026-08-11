//
//  WordleApp.swift
//  Wordle
//
//  Created by Popov Alexsandr on 15.06.2026.
//

import SwiftUI

@main
struct WordleApp: App {
    private let container = AppDIContainer()
    @State var path: NavigationPath = .init()
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                GameView(
                    viewModel: container.makeGameViewModel(),
                    path: $path
                )
                    .navigationDestination(for: NavigationPage.self) { page in
                        switch page {
                        case .statistics:
                            StatisticsView(
                                viewModel: container.makeStatisticsViewModel(),
                                path: $path
                            )
                        case .rules:
                            RulesView(path: $path)
                        }
                    }
            }
        }
    }
}
