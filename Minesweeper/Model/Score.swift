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
        guard let level = (aDecoder.decodeObject(forKey: "level") as? String), let name = aDecoder.decodeObject(forKey: "name") as? String, let time = aDecoder.decodeObject(forKey: "time") as? String else { return nil }
        self.level = level
        self.name = name
        self.time = Int(time)!
    }
    
    init(level:String,name:String,time:Int) {
        self.level = level
        self.name = name
        self.time = time
    }
    
    static func loadFromDisk() -> [String:[Score]]?{
        if let data = UserDefaults.standard.object(forKey: RECORDS_NAME_FILE) as? Data, let scores = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String:[Score]]
        {
            return scores
        }
        return nil
    }
    
    static func save(score:Score){
        var scores:[String:[Score]]? = loadFromDisk()
        if scores != nil{
            if scores?[score.level] != nil {
                    scores?[score.level]?.append(score)
                    scores?[score.level]?.sort{$0.time < $1.time}
            }
            else{
                scores?.updateValue([score], forKey: score.level)
            }
        }
        else
        {
            
            scores = [score.level:[score]]
        }
        saveToFile(scores: scores!, difficulty: score.level)
    }
    
    static func saveToFile(scores:[String:[Score]], difficulty:String){
        var tempScores = scores
        if scores[difficulty]?.count != nil , scores[difficulty]!.count > 10
        {
            tempScores[difficulty]!.remove(at: scores[difficulty]!.count-1)
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: tempScores)
        UserDefaults.standard.set(data, forKey: RECORDS_NAME_FILE)
   
    }
    
    
    
}
