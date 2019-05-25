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
    
    
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var scoreTableView: UITableView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 10000
    
    
    static var difficulty = "Easy"
    
    var scoresDictionary:[String:[Score]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoreTableView.rowHeight = 35
        self.scoreTableView.tableFooterView = UIView()
        scoresDictionary = Score.loadFromDisk() 
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
        
        checkLocationServices()
        btPressed(buttonsCollection[0])
      //  findUserLocationAndDropPin()

    }
    
    

    @IBAction func btPressed(_ sender: UIButton) {
       sender.showsTouchWhenHighlighted = true
       if let title = sender.titleLabel?.text{
            HighScoreViewController.difficulty = title
            lockAllButtonsExceptThis(buttonsColletion: self.buttonsCollection, title: title)
            removeAnottations()
            findUserLocationAndDropPin()
            DispatchQueue.main.async { self.scoreTableView.reloadData()
                self.releaseAllButtons(buttonsColletion: self.buttonsCollection)
        }
        }
        
    }
    func lockAllButtonsExceptThis(buttonsColletion: [UIButton], title: String){
        for i in 0..<buttonsCollection.count{
            if buttonsCollection[i].currentTitle == title {
                buttonsCollection[i].backgroundColor = UIColor.cyan
            }
            else{
                buttonsCollection[i].backgroundColor = UIColor.lightGray
                buttonsCollection[i].isEnabled = false
            }
        }
    }
    func releaseAllButtons(buttonsColletion: [UIButton]){
        for i in 0..<buttonsCollection.count{
            buttonsCollection[i].isEnabled = true
        }
    }
    
    func removeAnottations(){
        let annotations = self.mapView.annotations
            for _annotation in annotations {
                if let annotation = _annotation as? MKAnnotation{
                    self.mapView.removeAnnotation(annotation)
                }
        }
    }
    
     func findUserLocationAndDropPin() {
       // var pinForUserLocation = MKPointAnnotation()
        if scoresDictionary?[HighScoreViewController.difficulty] != nil {
            for i in 0..<scoresDictionary![HighScoreViewController.difficulty]!.count{
                let latitude = scoresDictionary![HighScoreViewController.difficulty]![i].latitude
                let longitude = scoresDictionary![HighScoreViewController.difficulty]![i].longitude
                let userLocationCoordinates = CLLocationCoordinate2DMake(latitude, longitude)
                print("\n\(latitude)\n")
                print(longitude)
                let pinForUserLocation = MKPointAnnotation()
                pinForUserLocation.coordinate = userLocationCoordinates
                pinForUserLocation.title =  scoresDictionary![HighScoreViewController.difficulty]![i].name
                pinForUserLocation.subtitle = "\(scoresDictionary![HighScoreViewController.difficulty]![i].time)s"
                mapView.addAnnotation(pinForUserLocation)
                mapView.showAnnotations([pinForUserLocation], animated: true)

            }
        
        //mapView.showAnnotations([pinForUserLocation], animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoresDictionary?[HighScoreViewController.difficulty]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Score Cell") as! ScoreTableViewCell
        cell.nameLabel.text = scoresDictionary?[HighScoreViewController.difficulty]?[indexPath.row].name
        cell.timeLabel.text = "\(scoresDictionary?[HighScoreViewController.difficulty]?[indexPath.row].time ?? -1)s"
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


