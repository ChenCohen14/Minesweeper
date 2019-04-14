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
    
    override func viewDidLoad() {
        userName.placeholder = "Enter your name"
        userName.resignFirstResponder()
    }
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let difficultyVC = segue.destination as! DifficultyVC
        name = userName.text!
        difficultyVC.name = name
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    

    
}

