//
//  HighScoreViewController.swift
//  Minesweeper
//
//  Created by Chen Cohen on 14/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class HighScoreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var scoreTableView: UITableView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    
    var scoresDictionary:[Difficulty:[Score]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoreTableView.rowHeight = 35
        self.scoreTableView.tableFooterView = UIView()
        if let scoresArray = Score.loadFromDisk() {
            self.scoresDictionary = [:]
            self.scoresDictionary?[Difficulty.Easy] = scoresArray.filter( { $0.level == Difficulty.Easy.rawValue } )
            self.scoresDictionary?[Difficulty.Medium] = scoresArray.filter({ (score) -> Bool in
                if score.level == Difficulty.Medium.rawValue {
                    return true
                } else {
                    return false
                }
            })
            self.scoresDictionary?[Difficulty.Hard] = scoresArray.filter( { $0.level == Difficulty.Hard.rawValue } )

        }
        if scoresDictionary != nil{
            scoreTableView.delegate = self
            scoreTableView.dataSource = self
        }
        
        checkLocationServices()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresDictionary?[Difficulty.Easy]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Score Cell") as! ScoreTableViewCell
        cell.nameLabel.text = scoresDictionary?[Difficulty.Easy]?[indexPath.row].name
        cell.timeLabel.text = "\(scoresDictionary?[Difficulty.Easy]?[indexPath.row].time ?? -1)s"
        cell.rankLabel.text = "\(indexPath.row + 1)."
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Home"
        navigationItem.backBarButtonItem = backItem
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Show an alert letting them know what's up
            break
        case .authorizedAlways:
            break
        }
    }
    
}

extension HighScoreViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    

}


