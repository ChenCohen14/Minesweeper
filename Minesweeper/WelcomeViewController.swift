//
//  ViewController.swift
//  Minesweeper
//
//  Created by Chen Cohen on 02/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    

    
    //built in method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
}

