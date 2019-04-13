//
//  MineField.swift
//  Minesweeper
//
//  Created by Chen Cohen on 08/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import Foundation

// Mine field class - the game board
class MineField {
    
    var rows = 0
    var cols = 0
    var mineNum : Int
    var gameGrid : [Cell] = []
    
    //Constructor - initialize the grid values and the mines positions
    init (rows : Int,cols:Int, mineNum:Int) {
        self.rows = rows
        self.cols = cols
        self.mineNum = mineNum
        initGameGrid()
        generateMines()
    }
    
    func getRows() -> Int {
        return rows
    }
    
    func getCols() -> Int {
        return cols
    }
    
    func getMineNum() -> Int {
        return mineNum
    }
    
    //reveal the cell
    func reveal(row: Int,col: Int) -> Void
    {
        gameGrid[row*self.cols+col].setCovered(covered: false)
    }
    
    //flaged the cell
    func flag(row: Int, col: Int, on_off: Bool) -> Void
    {
        gameGrid[row*self.cols+col].setFlagged(flagged: on_off)
    }
    
    //checks if the cell is mined
    func checkMine(row: Int, col: Int)-> Bool {
        if gameGrid[row*self.cols+col].getValue() == Cell.MINE_VALUE {
            return true
        }
        else{
            return false
        }
    }
    
    //initialize game grid , cell values to zero
    func initGameGrid() -> Void{
        for row in 0..<self.rows{
            for col in 0 ..< self.cols{
                gameGrid.append(Cell(value: 0))
            }
        }
    }
    
    //randomize the mines positions
    func generateMines() -> Void {
        var randomRow = 0
        var randomCol = 0
        var i = 0
        while (i < mineNum) {
            randomRow =  Int(Double.random(in:0..<1) * Double(rows))
            randomCol =  Int(Double.random(in:0..<1) * Double(cols))
            if (!checkMine(row: randomRow,col: randomCol)) {
                gameGrid[randomRow*self.cols+randomCol] = Cell(value: Cell.MINE_VALUE)
                adjustNeighboursValues(row: randomRow,col: randomCol)
                i+=1
            }
        }
    }
    
    //add mine to mine field
    func addMine() -> Void {
        var randomRow = 0
        var randomCol = 0
        randomRow =  Int(Double.random(in:0..<1) * Double(rows))
        randomCol =  Int(Double.random(in:0..<1) * Double(cols))
        if (!checkMine(row: randomRow,col: randomCol)) {
            mineNum+=1
            gameGrid[randomRow*self.cols+randomCol].setMineValue()
            adjustNeighboursValues(row: randomRow,col: randomCol)
        }
    }
    
    //adjusting mined cell neighbours values
    func adjustNeighboursValues(row: Int, col: Int)-> Void{
        var i=1, j=1;
        
        //last row
        if row == rows-1{
            i = -1
        }
        
        //last column
        if col == cols-1{
            j = -1
        }
        
        //left,right,and bottom left neighbours
        gameGrid[(row+i)*self.cols+col].increaseValue()
        gameGrid[row*self.cols+col+j].increaseValue()
        gameGrid[(row+i)*self.cols+col+j].increaseValue()
        
        //first or last row
        if(row == 0 || row==rows-1){
            if (col != 0 && col != cols-1){
                gameGrid[row*self.cols+col-j].increaseValue()
                gameGrid[(row+i)*self.cols+col-j].increaseValue()
            }
        }
            
            //middle rows
        else  {
            gameGrid[(row-i)*self.cols+col].increaseValue()
            gameGrid[(row-i)*self.cols+col+j].increaseValue()
            
            //first or last column
            if(col != 0 && col != cols-1){
                gameGrid[(row-i)*self.cols+col-j].increaseValue()
                gameGrid[row*self.cols+col-j].increaseValue()
                gameGrid[(row+i)*self.cols+col-j].increaseValue()
            }
        }
    }
    
    //recursive function to reveal the neighbours of cell that were pressed
    func revealNeighbours(row: Int,col: Int) -> Void {
        let minX = (row <= 0 ? 0 : row - 1)
        let minY = (col <= 0 ? 0 : col - 1)
        let maxX = (row >= rows - 1 ? rows : row + 2)
        let maxY = (col >= cols - 1 ? cols : col + 2)
        
        // loop over all surrounding cells
        for i in minX ..< maxX{
            for j in minY ..< maxY {
                //checking id the cell is not MINED, REVEALED already  or FLAGGED
                if (!checkMine(row: i,col: j) && gameGrid[i*self.cols+j].isCovered() && !gameGrid[i*self.cols+j].isFlagged()) {
                    reveal(row: i, col: j)
                    if (gameGrid[i*self.cols+j].getValue() == 0) {
                        // call recursively
                        revealNeighbours(row: i, col: j)
                    }
                }
            }
        }
    }
    
    func getCell(row: Int,col: Int)-> Cell{
        return gameGrid[row*self.cols+col]
    }
    
    //update Mine Field after adding mines
    func updateMineField() -> Void{
        for i in 0..<rows {
            for j in 0..<cols{
                gameGrid[i*self.cols+j].setCovered(covered: true);
                gameGrid[i*self.cols+j].setRemoveFlag(removeFlag: false);
            }
        }
    }
}
