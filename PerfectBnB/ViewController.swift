//
//  ViewController.swift
//  PerfectBnB
//
//  Created by Syed Nooruddin Fahad on 10/02/21.
//

import UIKit
import SwiftUI
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var btn: UIButton!
    
    @IBOutlet var lbl: UILabel!
    let locationManager = CLLocationManager()
    var latitude = ""
    var longitude = ""
    
    @IBAction func btnDetect(_ sender: Any) {
       showAlert()
        if btn.currentTitle == "Start Search!" {
            locationManager.stopUpdatingLocation()
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

            guard let cityViewController = mainStoryboard.instantiateViewController(identifier: "CityViewController") as? CityViewController else {
                print("Couldn't Find The View Controller")
                return
            }

            navigationController?.pushViewController(cityViewController, animated: true)
            
        } else {
            print("Check For Errors")
        }
    }
    

    let db = DBHelper()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locationValue : CLLocationCoordinate2D = manager.location?.coordinate else {
            return
            
        }
        print("\nLatitude :  \(locationValue.latitude)")
        print("Longitude : \(locationValue.longitude)")
        
        btn.setTitle("Start Search!", for: .normal)
        self.lbl.isHidden = false
        
        latitude = String(locationValue.latitude)
        longitude = String(locationValue.longitude)
//        let latitude: String = location.latitude.appending(String(locationValue.longitude))
//        let longitude: String = location.longitude.appending(String(locationValue.latitude))
        locationManager.stopUpdatingLocation()
        
        self.db.insert(latitude: latitude, longitude: longitude)
        self.db.query()
        print(self.db.query().latitude ?? "")
        print(self.db.query().longitude ?? "")
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showAlert() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        else { alert()}
    }
    
    func alert() {
    let alertController = UIAlertController (title: "To Enable Location", message: "Go to Settings > Privacy > Location Services and Enabled", preferredStyle: .alert)

    let settingsAction =
     UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
         UIApplication.shared.open(URL(string: "App-Prefs:root=Privacy")!)
    }
    alertController.addAction(settingsAction)
    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
    alertController.addAction(cancelAction)

    present(alertController, animated: true, completion: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
      
   }
    
}

