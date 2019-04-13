//
//  GameBoardVC.swift
//  Minesweeper
//
//  Created by Chen Cohen on 09/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import UIKit

class GameBoardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  

    @IBOutlet weak var imagesCollection : UICollectionView!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var level = ""
    var isFlag = false
     var gameManger : GameManager!
    var imageCells:[ImageCollectionViewCell]=[]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesCollection.dataSource = self
        imagesCollection.delegate = self
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height

        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 25, height: 25)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        imagesCollection.collectionViewLayout = layout
        
        var theLevel = Difficulty.getDifficultyBy(difficultyname: level)
        self.gameManger = GameManager(level: theLevel)


        print(level)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameManger.getBoard().getCols()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameManger.getBoard().getRows()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            imageCells.append(cell)
            return cell
        }

        return ImageCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.section)
        print(indexPath.row)
        gameManger.gameMove(row: indexPath.section, col: indexPath.row, flag: isFlag)
        let cell=collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        if(isFlag){
            cell.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
            cell.imageName = "flag"
        }
        else{
            cell.imageName = "cell"
        }
     //   imagesCollection.reloadItems(at: [indexPath])
        cell.changeImage()
       imagesCollection.reloadItems(at: [indexPath])

        
    }


    @IBAction func flagPressed(_ sender: UIButton) {
        if sender.currentTitle == "Off"{
            sender.setTitle("On", for: .normal)
            isFlag = true
        } else {
            sender.setTitle("Off", for: .normal)
            isFlag = false
        }
        
    }
    
}


  
    

