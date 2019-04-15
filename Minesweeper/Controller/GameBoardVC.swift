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
    var timer = Timer()
    var counter = 0
    var startTimer = false
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var level = ""
    var isFlag = false
    var gameOver = false
    var gameManager : GameManager!
    var imageCells:[ImageCollectionViewCell]=[]
    var minesLeft = 0
    var userName = " "
    
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
        
        let theLevel = Difficulty.getDifficultyBy(difficultyname: level)
        self.gameManager = GameManager(level: theLevel)
        
        minesLeft = gameManager.getBoard().getMineNum()
        minesLabel.text = "\(minesLeft)"
        userNameLabel.text = userName
        
        
        
        
        
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
        gameOver = !gameManager.gameMove(row: indexPath.section, col: indexPath.row, flag: isFlag)
        let imageCell=collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        if !startTimer{
            startTimer = true
            self.timer=Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
            {
                [weak self] timer in
                self!.counter+=1
                self!.timeLabel.text = "\(self!.counter)"
                if self!.gameManager.checkIsGameOver() || self!.gameManager.isWinning()
                {
                    let message = self!.gameManager.isWinning() ? "You Win!" : "You Lose"
                    timer.invalidate()
                    if self!.gameManager.isWinning(){
                        let score = Score(name: self!.userName, time: self!.counter)
                        Score.save(score: score)
                    }
                            
                        
                    let alert = UIAlertController(title: "Minesweeper Game", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default)
                    {
                        [weak self] action in
                        self?.navigationController?.popViewController(animated: true)
                    })
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        
        let position = indexPath.section*gameManager.getBoard().getCols()+indexPath.row
        let logicCell = gameManager.getBoard().gameGrid[position]
        if (imageCell.isFlag == true && logicCell.isFlagged() == true){ // if cell is already flagged don't update the UI
            return
        }
        else if (imageCell.isFlag == false && logicCell.isFlagged() == true){
            minesLeft -= 1
        }
        else if (imageCell.isFlag == true && logicCell.isFlagged() == false){
            minesLeft += 1
        }
        updateUI()
        imagesCollection.reloadInputViews()
        
        
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
                let cell = gameManager.getBoard().getCell(row: row, col: col)
                let imageCell = imageCells[(row*gameManager.getBoard().getCols())+col]
                
          
                
                imageCell.isFlag = cell.flagged
                imageCell.number = "\(cell.getValue())"
                if(gameOver){
                    imageCell.covered = false
                }
                else{
                    imageCell.covered = cell.isCovered()
                }
                imageCell.changeImage()
                
            }
        }
        minesLabel.text = "\(minesLeft)"
    }
    

    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
        imagesCollection.delegate=nil
        imagesCollection.dataSource=nil
    }
    
    
    
}





