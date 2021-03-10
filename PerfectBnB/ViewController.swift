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
    
    func alert() {
        let alertController = UIAlertController(title: NSLocalizedString("Turn On Location Services to Allow PerfectBnB to Determine Your Location", comment: ""), message: NSLocalizedString("", comment: ""), preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: NSLocalizedString("Settings", comment: ""), style: .default) { (UIAlertAction) in
            UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
                    }

        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
                    self.present(alertController, animated: true, completion: nil)
    }

    func showAlert() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        } else { alert()}
    }
    
}

