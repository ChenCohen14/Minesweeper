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
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var level = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonsCollection.dataSource = self
        buttonsCollection.delegate = self
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 35, height: 35)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        buttonsCollection.collectionViewLayout = layout


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


  
    

