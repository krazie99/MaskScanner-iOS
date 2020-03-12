//
//  SMTMapView.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/12.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import SwiftUI
import MapKit

struct SMTMapView: UIViewRepresentable, MapViewProtocol {
    
    @Binding var showMapAlert: Bool
    var annotations: [MKPointAnnotation]?
    var locationManager: CLLocationManager? = nil
    
    var mapView: UIView {
        return mtMapView
    }
    
    private let mtMapView: MTMapView = {
        let map = MTMapView(frame: .zero)
        map.baseMapType = .standard
        map.currentLocationTrackingMode = .onWithoutHeading
        map.showCurrentLocationMarker = true
        return map
    }()
    
    func makeUIView(context: Context) -> MTMapView {
//        locationManager.delegate = context.coordinator
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters

        mtMapView.delegate = context.coordinator
        return mtMapView
    }
    
    func updateUIView(_ uiView: MTMapView, context: Context) {
        print("Updating")
//        if let annotations = annotations,
//            annotations.count != uiView.annotations.count {
//            uiView.removeAnnotations(uiView.annotations)
//            uiView.addAnnotations(annotations)
//        }
    }
    
    ///Use class Coordinator method
    func makeCoordinator() -> LocationCoordinator {
        return LocationCoordinator(mapView: self)
    }
    
//    func setRegion(_ region: MKCoordinateRegion, animated: Bool) {
//        let geo = MTMapPointGeo(latitude: region.center.latitude, longitude: region.center.longitude)
//        mtMapView.setMapCenter(MTMapPoint(geoCoord: geo), zoomLevel: 1, animated: animated)
//    }
}

struct SMTMapView_Preview: PreviewProvider {
    static var previews: some View {
        SMTMapView(showMapAlert: .constant(false), annotations: [MKPointAnnotation.example])
    }
}

extension LocationCoordinator: MTMapViewDelegate {
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {

        let currentLocationPointGeo = location.mapPointGeo()
        print("MTMapView updateCurrentLocation (\(currentLocationPointGeo.latitude)), \(currentLocationPointGeo.longitude) accuracy (\(accuracy))")
        
        mapView.setMapCenter(MTMapPoint(geoCoord: currentLocationPointGeo), zoomLevel: 1, animated: true)
    }
    
    func mapView(_ mapView: MTMapView!, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView updateDeviceHeading (\(headingAngle))) degrees")
    }
}
