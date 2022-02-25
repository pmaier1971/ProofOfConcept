//
//  LocationViewModel.swift
//  ProofOfConcept
//
//  Created by Philipp Maier on 2/23/22.
//

import Foundation
import MapKit
// import CoreLocationUI

final class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40, longitude: -80.5), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
   
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAllowLocationPermission() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first else {
            print("Location Error #1")
            return
        }
        
        DispatchQueue.main.async {
            self.mapRegion = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        }
       
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error #2:")
        print(error.localizedDescription)
    }
    
}
