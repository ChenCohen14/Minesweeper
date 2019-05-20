//
//  ViewController.swift
//  Minesweeper
//
//  Created by Chen Cohen on 02/04/2019.
//  Copyright © 2019 Chen Cohen. All rights reserved.
//

import UIKit
import CoreLocation

class WelcomeVC: UIViewController {

  
    @IBOutlet weak var userName: UITextField!
    
    var name = " "
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        userName.placeholder = "Enter your name"
        userName.resignFirstResponder()
        checkLocationServices()

    }
    
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let button: UIButton = sender as! UIButton
        if button.currentTitle == "Play"
        {
        let difficultyVC = segue.destination as! DifficultyVC
        name = userName.text ?? ""
        difficultyVC.name = name
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


    

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
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

extension WelcomeVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
