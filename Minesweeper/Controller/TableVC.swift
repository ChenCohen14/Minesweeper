//
//  TableVC.swift
//  Minesweeper
//
//  Created by Chen Cohen on 14/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import UIKit

class TableVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var people = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
extension TableVC : UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = people[indexPath.row].name
        cell.detailTextLabel?.text = String(people[indexPath.row].time)
        return cell
        
    }
    
    
}
