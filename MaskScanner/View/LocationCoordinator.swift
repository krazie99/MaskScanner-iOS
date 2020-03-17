//
//  LocationCoordinator.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/12.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import Foundation
import MapKit

class LocationCoordinator: NSObject {
    
    var mainMapView: MapViewProtocol
    var locationManager: CLLocationManager?
    
    fileprivate var beforeRegion: MKCoordinateRegion?
    
    init(mapView: MapViewProtocol, locationManager: CLLocationManager? = nil) {
        self.mainMapView = mapView
        self.locationManager = locationManager
        super.init()
        initLocationManager()
    }
    
    private func initLocationManager() {
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
}
   
//MARK: - CLLocationManager Delegate
extension LocationCoordinator: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            break
        case .denied:
            self.mainMapView.viewModel?.showMapAlert.toggle()
            return
        case .notDetermined:
            self.locationManager?.requestWhenInUseAuthorization()
            return
        case .authorizedAlways:
            self.locationManager?.allowsBackgroundLocationUpdates = true
            self.locationManager?.pausesLocationUpdatesAutomatically = false
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
        self.locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, let locationManager = self.locationManager else { return }
        
        // 위치정보 반환
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        // MKCoordinateSpan -- 지도 scale
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta:0.01, longitudeDelta:0.01))
        self.mainMapView.setRegion(region, needUpdate: true, animated: false)
        self.mainMapView.viewModel?.canRefresh = false
        locationManager.stopUpdatingLocation()
    }
}

//MARK: - MKMapViewDelegate Delegate
extension LocationCoordinator: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? MaskAnnotation {
            print("Annotation: \(annotation.title ?? "") : \(annotation.subtitle ?? "")")
            self.mainMapView.viewModel?.selectedAnnotation = annotation
        } else if let cluster = view.annotation as? MKClusterAnnotation {
            print("Annotations count: \(cluster.memberAnnotations.count)")
            self.mainMapView.viewModel?.selectedAnnotations = cluster.memberAnnotations as? [MaskAnnotation]
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if let center = beforeRegion?.center {
            let distance = CLLocation.distance(from: center, to: mapView.region.center)
            if distance > 1000 {
                self.mainMapView.viewModel?.canRefresh = true
                self.mainMapView.setRegion(mapView.region, needUpdate: false, animated: false)
            }
        }
        beforeRegion = mapView.region
    }
}

//MARK: - MTMapViewDelegate Delegate
extension LocationCoordinator: MTMapViewDelegate {
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        let currentLocationPointGeo = location.mapPointGeo()
        print("MTMapView updateCurrentLocation (\(currentLocationPointGeo.latitude)), \(currentLocationPointGeo.longitude) accuracy (\(accuracy))")
        
        mapView.setMapCenter(MTMapPoint(geoCoord: currentLocationPointGeo), zoomLevel: 1, animated: true)
        self.mainMapView.viewModel?.regionTuple = (currentLocationPointGeo.latitude, currentLocationPointGeo.longitude)
    }
    
    func mapView(_ mapView: MTMapView!, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView updateDeviceHeading (\(headingAngle))) degrees")
    }
}
