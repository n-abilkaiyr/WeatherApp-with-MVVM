//
//  LocationManager.swift
//  WeatherAppMVVM
//
//  Created by Abilkaiyr Nurzhan on 06.02.2022.
//

import Foundation
import CoreLocation

class LocationManager: CLLocationManager, CLLocationManagerDelegate {
    static let shared = LocationManager()
    
    private var  lat : CLLocationDegrees!
    private var lon : CLLocationDegrees!
    
    var completion: ((CLLocationDegrees, CLLocationDegrees) -> Void)?
    
    private override init() {
        super.init()
        requestWhenInUseAuthorization()
        delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            stopUpdatingLocation()
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            completion?(lat, lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR: \(error.localizedDescription)")
    }
    
    func fetchLocation() {
        requestLocation()
    }
    
    
    
    
}
