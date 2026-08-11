//
//  KayState.swift
//  Wordle
//
//  Created by Popov Alexsandr on 23.06.2026.
//

import SwiftUI

struct KeyState {
    let key: String
    var status: LetterStatus?
    
    var backgroudColor: LinearGradient {
        switch status {
        case .correctPosition:
            return LinearGradient(colors: [.appGreen1, .appGreen2], startPoint: .top, endPoint: .bottom)
        case .wrongPosition:
            return LinearGradient(colors: [.appOrange1, .appOrange2], startPoint: .top, endPoint: .bottom)
        case .notInWord:
            return LinearGradient(colors: [.appDarkGray, .appDarkGray], startPoint: .top, endPoint: .bottom)
        case nil:
            return LinearGradient(colors: [.appGray, .appGray], startPoint: .top, endPoint: .bottom)

        }
    }
}


