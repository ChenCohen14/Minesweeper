//
//  Timer.swift
//  Minesweeper
//
//  Created by Chen Cohen on 08/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import Foundation

//Game Time Class
public class Timer{
    var ticks: Int
    var isTimerOn: Bool
    
    //init new game timer
    init() {
        self.ticks = 0;
        isTimerOn=false;
    }
    
    //increase game ticks
    func tick()-> Void {
        if(isTimerOn){
            ticks+=1
        }
        else{
            return
        }
    }
    
    func getTicks()-> Int {
        return ticks
    }
    
    func setTimerOn(timerOn: Bool)-> Void {
        isTimerOn = timerOn
    }
}

