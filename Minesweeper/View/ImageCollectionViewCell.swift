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
    var covered = true
    var isFlag = false
    
    
    func changeImage(){
        print(" in changeImage()")
        print(imageName)
        
        if(!covered){
            //self.imageCell.removeFromSuperview()
            self.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            if number == "\(Cell.MINE_VALUE)"{
                imageName = "bomb"
            }
            else{
            hintNumber.text = number
            }
            self.isUserInteractionEnabled = false

        }
        else if(isFlag){
            imageName = "flag"
            self.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        }
        else{
            self.backgroundColor = #colorLiteral(red: 0.2404436574, green: 1, blue: 0.1474604859, alpha: 1)
            imageName = "cell"
        }

        imageCell.image = UIImage(named: imageName)

        print(" after changeImage()")
     

    }
 
}
