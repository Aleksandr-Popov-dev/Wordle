//
//  AppDIContainer.swift
//  Wordle
//
//  Created by Popov Alexsandr on 22.06.2026.
//

import Foundation

final class AppDIContainer {
    
    //MARK: - CoreData
    private lazy var coreDataStack: CoreDataStack = {
        return CoreDataStack.shared
    }()
    
    // MARK: - Repositories
    private lazy var wordRepository: WordRepositoryProtocol = {
        WordRepository()
    }()
    
    private lazy var statisticsRepository: StatisticsRepositoryProtocol = {
        CoreDataStatisticsRepository(coreDataStack: coreDataStack)
    }()
    
    // MARK: - UseCases
    private lazy var validateWordUseCase: ValidateWordUseCase = {
        ValidateWordUseCase(wordRepository: wordRepository)
    }()
    
    private lazy var getRandomWordUseCase: GetRandomWordUseCase = {
        GetRandomWordUseCase(wordRepository: wordRepository)
    }()
    
    private lazy var evaluateAttemptUseCase: EvaluateAttemptUseCase = {
        EvaluateAttemptUseCase()
    }()
    
    private lazy var saveGameResultUseCase: SaveGameResultUseCase = {
        SaveGameResultUseCase(statisticsRepository: statisticsRepository)
    }()
    
    private lazy var getStatisticsSummaryUseCase: GetStatisticsSummaryUseCase = {
        GetStatisticsSummaryUseCase(statisticsRepository: statisticsRepository)
    }()
    
    func makeGameViewModel() -> GameViewModel {
        GameViewModel(
            validateWordUseCase: validateWordUseCase,
            evaluateAttemptUseCase: evaluateAttemptUseCase,
            getRandomWordUseCase: getRandomWordUseCase,
            saveGameResultUseCase: saveGameResultUseCase
        )
    }
    
    func makeStatisticsViewModel() -> StatisticsViewModel {
        StatisticsViewModel(
            getStatisticsSummaryUseCase: getStatisticsSummaryUseCase
        )
    }
}
