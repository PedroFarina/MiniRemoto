//
//  LocationHelper.swift
//  MiniRemoto
//
//  Created by Pedro Giuliano Farina on 27/05/20.
//  Copyright © 2020 Pedro Giuliano Farina. All rights reserved.
//

import MapKit

public class LocationHelper: NSObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    public private(set) var currentLocation: CLLocation?

    public var currentRegion: MKCoordinateRegion? {
        if let location = currentLocation {
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            return MKCoordinateRegion(center: location.coordinate, span: span)
        }
        return nil
    }

    public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location manager error" + error.localizedDescription)
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
    }

    public static func getFullAddress(from placemark: MKPlacemark) -> String {
        var finalAddress = ""
        if let t = placemark.thoroughfare {
            finalAddress += t + ", "
        }
        if let l = placemark.locality {
            finalAddress += l + ", "
        }
        if let s = placemark.subLocality {
            finalAddress += s + ", "
        }
        if let a = placemark.administrativeArea {
            finalAddress += a + ", "
        }
        if let p = placemark.postalCode {
            finalAddress += p + ", "
        }
        if let c = placemark.country {
            finalAddress += c + ", "
        }

        finalAddress = String(finalAddress.prefix(finalAddress.count - 2))

        return finalAddress
    }
}
