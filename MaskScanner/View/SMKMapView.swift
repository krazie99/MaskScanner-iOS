//
//  SMKMapView.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/12.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import SwiftUI
import MapKit

struct SMKMapView: UIViewRepresentable, MapViewProtocol {
    
    @Binding var showMapAlert: Bool
    @Binding var latiAndLng: (Double, Double)?
    
    var annotations: [MKPointAnnotation]?
    
    var locationManager: CLLocationManager? = CLLocationManager()
    var mapView: UIView {
        return mkMapView
    }
    
    private let mkMapView: MKMapView = {
        let map = MKMapView(frame: .zero)
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        return map
    }()

    func makeUIView(context: Context) -> MKMapView {
        locationManager?.delegate = context.coordinator
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("Updating")
        if let annotations = annotations,
            annotations.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(annotations)
        }
    }
    
    ///Use class Coordinator method
    func makeCoordinator() -> LocationCoordinator {
        return LocationCoordinator(mapView: self)
    }
    
    func setRegion(_ region: MKCoordinateRegion, animated: Bool) {
        mkMapView.setRegion(region, animated: animated)
    }
}


struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        SMKMapView(showMapAlert: .constant(false),
                   latiAndLng: .constant(MKPointAnnotation.exmpleLatiAndLng),
                   annotations: [MKPointAnnotation.example])
    }
}

extension MKPointAnnotation {
    static var exmpleLatiAndLng = (37.38932677417901, 127.1140780875495)
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "우리집"
        annotation.subtitle = "백현마을 4단지"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.38932677417901, longitude: 127.1140780875495)
        return annotation
    }
}
