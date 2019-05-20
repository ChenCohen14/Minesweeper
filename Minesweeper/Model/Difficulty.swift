//
//  Difficulty.swift
//  Minesweeper
//
//  Created by Chen Cohen on 08/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import Foundation

enum Difficulty: String {
    case Easy
    case Medium
    case Hard
    
    func getSecRow() -> (Int,Int,Int) {
        switch self {
        case .Easy:
            return (5,5,1)
        case .Medium:
            return (10,10,20)
        case .Hard:
            return (10,10,30)
        }
    }
    static func getDifficultyBy(difficultyname:String)->Difficulty{
        switch difficultyname {
        case "Easy":
            return .Easy
        case "Medium":
            return .Medium
        case "Hard":
            return .Hard
        default:
            return .Easy
        }
    }
}

