//
//  ViewController.swift
//  PlankRec
//
//  Created by Apple on 4/16/23.
//

import UIKit
import CoreData
import CoreLocation

class StartViewController: UIViewController {
    let locationManager = CLLocationManager()
    let aqi = AQI()
    
    @IBOutlet weak var aqiLabel: UILabel!
    
    override func viewDidLoad() {
     super.viewDidLoad()
        
        aqi.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
  }
    func showAQI() {
       
        var aqiColor = aqi.aqi<101 ? UIColor(ciColor: .green):UIColor(ciColor: .red)
        aqiLabel.backgroundColor = aqiColor
        aqiLabel.text = String(aqi.aqi)
    }
    
    

}

extension StartViewController : CLLocationManagerDelegate,AQIDelagate{
    
    func getAqi(_ aqi: Int) {
        showAQI()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = "\(location.coordinate.latitude)"
            let long = "\(location.coordinate.longitude)"
            aqi.getAQI(lat,long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
