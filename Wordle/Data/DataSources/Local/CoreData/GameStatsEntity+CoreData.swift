//
//  GameStatsEntity+CoreData.swift
//  Wordle
//
//  Created by Popov Alexsandr on 24.06.2026.
//

import Foundation
import CoreData


@objc(GameStatsEntity)
public class GameStatsEntity: NSManagedObject {
    
    //MARK: - Init
    convenience init(
        context: NSManagedObjectContext,
        targetWord: String,
        attempts: Int16,
        isWin: Bool
    ) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "GameStatsEntity", in: context) else {
            fatalError("cant find entity GameStatsEntity")
        }
        self.init(entity: entityDescription, insertInto: context)
        
        self.id = UUID()
        self.targetWord = targetWord
        self.attempts = attempts
        self.isWin = isWin
    }
}

//MARK: - Mapping
extension GameStatsEntity {
    func toDomain() -> GameStatistics {
        GameStatistics(
            id: id,
            targetWord: targetWord,
            attempts: Int(attempts),
            isWin: isWin
        )
    }
}


//MARK: - From Domain
extension GameStatsEntity {
    static func create (
        from staticstics: GameStatistics,
        context: NSManagedObjectContext
    ) -> GameStatsEntity {
        let entity = GameStatsEntity(
            context: context,
            targetWord: staticstics.targetWord,
            attempts: Int16(staticstics.attempts),
            isWin: staticstics.isWin
        )
        return entity
    }
}



