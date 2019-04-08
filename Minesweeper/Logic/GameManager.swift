//
//  GameManager.swift
//  Minesweeper
//
//  Created by Chen Cohen on 08/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import Foundation


//Game Manager Class, refers to all SINGLE game logic
public class GameManager {
    
    var board: MineField
    var time:Timer
  //  var highScore: HighScore
    var mineLeft: Int
    var firstMove: Bool
    var level: Difficulty
    var isGameOver : Bool
    var allBoardIsMined : Bool
    
    
    
    //initialize game grid by level
    init(level: Difficulty){
        self.level = level
        var rows: Int
        var cols: Int
        var mines: Int
        (rows,cols,mines) = level.getSecRow()
        self.board = MineField(rows: rows, cols: cols, mineNum: mines)
        
        self.mineLeft=board.getMineNum()
        self.time=Timer()
        self.firstMove=true
        self.isGameOver = false
        self.allBoardIsMined=false
    }
    
    //the game level enum
    func getLevel() -> Difficulty {
        return level;
    }
    
    //checks if the single game is in winning state - all not mined cells were revealed
    func isWinning() -> Bool{
        var isWon = true
        for i in 0..<board.getRows(){
            if isWon{
            for j in 0..<board.getCols(){
                if isWon{
                    if (board.getCell(row: i,col: j).isCovered() && !board.getCell(row: i,col: j).isFlagged()){
                    isWon = false
                    }
                    
                }
                }
            }
        }
        if((mineLeft==0 && isWon) || checkAllRevealed()) {
            isGameOver = true
            return true
        }
        else{
        return false
        }
    }
    
    //Check if all the non mined is revealed
    func checkAllRevealed()-> Bool{
        for i in 0..<board.getRows(){
            for j in 0..<board.getCols(){
                if (!(board.checkMine(row: i,col: j)) && (board.getCell(row: i,col: j).isCovered())){
                    return false;
                }
            }
        }
        return true
    }
    
    // return false if game over
    func gameMove( row: Int, col: Int,flag: Bool) -> Bool{
        
        if (firstMove) {
            //init timer - turn on ticks
            time.setTimerOn(timerOn: true)
            
            //turn off the first game move flag
            self.firstMove=false
        }
        //set a flag on the chosen cell
        if (flag) {
            if(!board.getCell(row: row, col: col).isFlagged() && board.getCell(row: row, col: col).isCovered()) {
                board.flag(row: row, col: col, on_off: true);
                mineLeft-=1
            }
        }
        else{
            if (board.getCell(row: row, col: col).isFlagged()) {
                board.getCell(row: row, col: col).setRemoveFlag(removeFlag: true)
                board.flag(row: row, col: col, on_off: false)
                mineLeft+=1
                return true
            }
            if (board.checkMine(row: row, col: col)){
                isGameOver = true
                return false
            }
            
            board.reveal(row: row, col: col);
            if (board.getCell(row: row, col: col).getValue()==0) {
                board.revealNeighbours(row: row, col: col);
            }
        }
        return true
    }
    
    // add mine to the game board
   func addMineToGame()-> Void {
        if(board.getMineNum() < board.getRows()*board.getCols()) {
            board.addMine()
            mineLeft = board.getMineNum()
        }
    }
    
    // update game board after adding mines
    func updateBoard() -> Void{
        board.updateMineField();
    }
    
    func checkIsGameOver() -> Bool {
        return isGameOver;
    }
    
   func getBoard() -> MineField {
        return board;
    }
    
    func getMineLeft() -> Int {
        return mineLeft;
    }
    
    func getTime() -> Timer {
        return time;
    }
    
//    func getHighScore() -> HighScore {
//        return highScore;
//    }
//
//    //sets the game high score record - player name, ticks from the timer, and the level
//    func setHighScore(Context context) -> Void {
//        this.highScore = new HighScore(time.getTicks(),level,context);
//    }
    
    //check if board is all mined
    func isAllBoardIsMined() -> Bool {
        if((board.getMineNum() == board.getRows()*board.getCols())) {
            self.allBoardIsMined=true
        }
        return self.allBoardIsMined
    }
    
    
}

