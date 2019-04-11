//
//  ButtonCell.swift
//  Minesweeper
//
//  Created by Chen Cohen on 07/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func changeImage(){
        print(" in changeImage()")
        imageView.image = UIImage(named: "minesweeperLogo")
        print(" after changeImage()")

    }
 
}
