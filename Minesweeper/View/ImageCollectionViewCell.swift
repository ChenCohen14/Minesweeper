//
//  ButtonCell.swift
//  Minesweeper
//
//  Created by Chen Cohen on 07/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hintNumber: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    var imageName = "cell"
    var number = ""
    var exposed = true
    
    func changeImage(){
        print(" in changeImage()")
        print(imageName)
        imageCell.image = UIImage(named: imageName)
        
        if(exposed){
            self.imageCell.removeFromSuperview()
            self.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            hintNumber.text = number
            
            self.isUserInteractionEnabled = false

        }
        print(" after changeImage()")
     

    }
 
}
