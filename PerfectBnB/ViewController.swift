//
//  ViewController.swift
//  PerfectBnB
//
//  Created by Syed Nooruddin Fahad on 10/02/21.
//

import UIKit
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
        print("Latitude :  \(locationValue.latitude)")
        print("Longitude : \(locationValue.longitude)")
        
        btn.setTitle("Start Search!", for: .normal)
        self.lbl.isHidden = false
        
        latitude = String(locationValue.latitude)
        longitude = String(locationValue.longitude)
        locationManager.stopUpdatingLocation()
        
        self.db.insert(latitude: latitude, longitude: longitude)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func showAlert() {
//        let alert = UIAlertController(title: "GPS is disabled", message: "Please enable it", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
//            print("Dismissed")
//        }))
//
//        alert.addAction(UIAlertAction(title: "Enable", style: .default, handler: { action in
//            // asking for permission
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
//
//    }))
//
//        present(alert, animated: true)
////        present(alert, animated: false, completion: nil)
//
    }
    
}

