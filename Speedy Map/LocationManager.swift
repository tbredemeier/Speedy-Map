//
//  LocationManager.swift
//  Speedy Map
//
//  Created by Tom Bredemeier on 6/1/25.
//

import Foundation
import MapKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    
    @Published var userLocation = CLLocationCoordinate2D()
    @Published var region = MKCoordinateRegion()
    @Published var speed = 0
    @Published var cityStateText: String = "Locating..."
    @Published var mapInteractionEnabled: Bool = false

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latest = locations.last else { return }
        userLocation = latest.coordinate
        speed = Int(max(latest.speed * 2.23694 + 0.5, 0)) // m/s to mph, no negative

        if !mapInteractionEnabled {
            centerMap()
        }
        
        geocoder.reverseGeocodeLocation(latest) { placemarks, _ in
            if let placemark = placemarks?.first {
                let city = placemark.locality ?? "Unknown City"
                let state = placemark.administrativeArea ?? "Unknown State"
                    self.cityStateText = "\(city), \(state)"
            }
        }
    }

    func centerMap() {
        region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
