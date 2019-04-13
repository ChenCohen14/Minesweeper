//
//  DifficultyVCViewController.swift
//  Minesweeper
//
//  Created by Chen Cohen on 09/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import UIKit

class DifficultyVC: UIViewController {
    var name = ""
    var level = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(name)
        
    }
    
 

    @IBAction func levelBtPressed(_ sender: UIButton) {
        level = sender.titleLabel!.text!
       // performSegue(withIdentifier: "GameBoardVC", sender: self)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameBoardVC = segue.destination as! GameBoardVC
        gameBoardVC.level = level
    }
}
