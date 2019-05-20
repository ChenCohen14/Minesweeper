//
//  Score.swift
//  Minesweeper
//
//  Created by Chen Cohen on 14/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//


import Foundation

class Score :NSObject,NSCoding {
    var level: String
    var name:String
    var time:Int
    static let RECORDS_NAME_FILE = "records"

    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.level, forKey: "level")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode("\(self.time)", forKey: "time")
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let level = aDecoder.decodeObject(forKey: "level") as? String, let name = aDecoder.decodeObject(forKey: "name") as? String, let time = aDecoder.decodeObject(forKey: "time") as? String else { return nil }
        self.level = level
        self.name = name
        self.time = Int(time)!
    }
    
    init(level:String,name:String,time:Int) {
        self.level = level
        self.name = name
        self.time = time
    }
    
    static func loadFromDisk() -> [Score]?{
        if let data = UserDefaults.standard.object(forKey: RECORDS_NAME_FILE) as? Data, let scores = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Score]
        {
            return scores
        }
        return nil
    }
    
    static func save(score:Score){
        var scores:[Score]? = loadFromDisk()
        if scores != nil {
            scores?.append(score)
            scores?.sort{$0.time < $1.time}
            
        }
        else
        {
            scores = [score]
        }
        saveToFile(scores: scores!)
    }
    
    static func saveToFile(scores:[Score]){
        var tempScores = scores
        if scores.count > 10
        {
            tempScores.remove(at: scores.count-1)
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: tempScores)
        UserDefaults.standard.set(data, forKey: RECORDS_NAME_FILE)
    }
    
    
    
}
