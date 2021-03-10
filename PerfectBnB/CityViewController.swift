//
//  CityViewController.swift
//  PerfectBnB
//
//  Created by Syed Nooruddin Fahad on 05/03/21.
//

import Foundation
import UIKit
import SwiftUI

class CityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let controller = UIHostingController(rootView: WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService())))
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
//            controller.view.widthAnchor.constraint(equalToConstant: 200),
//            controller.view.heightAnchor.constraint(equalToConstant: 44),
            controller.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
