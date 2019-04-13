//
//  ButtonCell.swift
//  Minesweeper
//
//  Created by Chen Cohen on 07/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    var imageName = "cell"
    
    func changeImage(){
        print(" in changeImage()")
        print(imageName)
        imageCell.image = UIImage(named: imageName)
        
        print(" after changeImage()")
     

    }
 
}
