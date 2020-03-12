//
//  LocationCoordinator.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/12.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import Foundation
import MapKit

//MARK: - Core Location manager delegate
class LocationCoordinator: NSObject, CLLocationManagerDelegate {
    
    var mapView: MapViewProtocol
    
    init(mapView: MapViewProtocol) {
        self.mapView = mapView
    }
    
    ///Switch between user location status
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            break
        case .denied:
            mapView.showMapAlert.toggle()
            return
        case .notDetermined:
            mapView.locationManager?.requestWhenInUseAuthorization()
            return
        case .authorizedAlways:
            mapView.locationManager?.allowsBackgroundLocationUpdates = true
            mapView.locationManager?.pausesLocationUpdatesAutomatically = false
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
        mapView.locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, let locationManager = mapView.locationManager else { return }
        
        // 위치정보 반환
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        // MKCoordinateSpan -- 지도 scale
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta:0.01, longitudeDelta:0.01))
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
}
