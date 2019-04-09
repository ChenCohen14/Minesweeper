//
//  ViewController.swift
//  Minesweeper
//
//  Created by Chen Cohen on 02/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

  
    @IBOutlet weak var userName: UITextField!
    
    var name = ""
    
    
    
    @IBAction func playPressed(_ sender: UIButton) {
            name = userName.text!
            performSegue(withIdentifier: "DifficultyVC", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let difficultyVC = segue.destination as! DifficultyVC
        difficultyVC.name = name
    }


    

    
}

