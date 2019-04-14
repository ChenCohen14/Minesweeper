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
    
    @IBOutlet weak var minesLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var level = ""
    var isFlag = false
    var gameOver = false
    var gameManager : GameManager!
    var imageCells:[ImageCollectionViewCell]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagesCollection.dataSource = self
        imagesCollection.delegate = self
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        // Do any additional setup after loading the view, typically from a nib.
        var space = 0
        if level == "Easy"{
            space = 70
        }
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(space), bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 25, height: 25)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        imagesCollection.collectionViewLayout = layout
        
        var theLevel = Difficulty.getDifficultyBy(difficultyname: level)
        self.gameManager = GameManager(level: theLevel)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameManager.getBoard().getCols()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gameManager.getBoard().getRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            imageCells.append(cell)
            return cell
        }
        
        return ImageCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gameManager.gameMove(row: indexPath.section, col: indexPath.row, flag: isFlag)
        gameOver = gameManager.isGameOver
        let cell=collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        //        if(isFlag){
        //            cell.imageName = "flag"
        //            cell.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        //        }
        //        else{
        //            cell.backgroundColor = #colorLiteral(red: 0.2404436574, green: 1, blue: 0.1474604859, alpha: 1)
        //            cell.imageName = "cell"
        //        }
        //   imagesCollection.reloadItems(at: [indexPath])
        // cell.changeImage()
        var position = indexPath.section*gameManager.getBoard().getCols()+indexPath.row
        var logicCell = gameManager.getBoard().gameGrid[position]
        if (cell.isFlag == true && logicCell.isFlagged() == true){
            return
        }
        updateUI()
        imagesCollection.reloadItems(at: [indexPath])
        
        
    }
    
    
    @IBAction func flagPressed(_ sender: UIButton) {
        if sender.currentTitle! == "Off"{
            sender.setTitle("On", for: .normal)
            isFlag = true
        } else {
            sender.setTitle("Off", for: .normal)
            isFlag = false
        }
        
    }
    
    func updateUI(){
        for row in 0..<gameManager.getBoard().getRows(){
            for col in 0..<gameManager.getBoard().getCols(){
                var cell = gameManager.getBoard().getCell(row: row, col: col)
                var imageCell = imageCells[(row*gameManager.getBoard().getCols())+col]
               
                
                print("\(row)" + "\(col)")
                print("\(cell.flagged)")
                print(imageCell.isFlag)
           
                imageCell.isFlag = cell.flagged
                imageCell.number = "\(cell.getValue())"
                if(gameOver){
                    imageCell.covered = false
                    // TODO: the flag sign doesnt work well
                }
                else{
                    imageCell.covered = cell.isCovered()
                }
                imageCell.changeImage()
                
                
                
                
            }
        }
        
    }
    
    
    
}





