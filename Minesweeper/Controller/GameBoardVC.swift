//
//  GameBoardVC.swift
//  Minesweeper
//
//  Created by Chen Cohen on 09/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import UIKit

class GameBoardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  

    @IBOutlet weak var buttonsCollection : UICollectionView!
    var level = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonsCollection.dataSource = self
        buttonsCollection.delegate = self


        print(level)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as? ButtonCell {
            return cell
        }

        return ButtonCell()
    }


}


  
    

