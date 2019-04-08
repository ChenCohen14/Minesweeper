//
//  Cell.swift
//  Minesweeper
//
//  Created by Chen Cohen on 08/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import Foundation


// The cell class
class Cell {
    var value : Int
    var flagged : Bool
    var covered : Bool
    var removeFlag : Bool
    static let MINE_VALUE = -1;
    
    //initialize cell, not flagged, covered(not revealed-'pressed")
    init (value : Int) {
        self.value=value
        self.flagged=false
        self.covered=true
        self.removeFlag=false
    }
    
    func getValue() -> Int{
        return value;
    }
    
    // increse the cell value by one
    func increaseValue() -> Void {
        if value != Cell.MINE_VALUE {
            self.value+=1;
        }
    }
    
    func setMineValue() -> Void{
        self.value = Cell.MINE_VALUE;
    }
    
    func isFlagged() -> Bool {
        return flagged;
    }
    
    func isCovered() -> Bool {
        return covered;
    }
    
    func setFlagged(flagged: Bool) -> Void {
        self.flagged = flagged;
    }
    
    func setCovered(covered: Bool) -> Void {
        self.covered = covered;
    }
    
    func isRemoveFlag() -> Bool {
        return removeFlag;
    }
    
    func setRemoveFlag(removeFlag : Bool) -> Void {
        self.removeFlag = removeFlag;
    }
}
