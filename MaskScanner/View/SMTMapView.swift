//
//  SMTMapView.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/12.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import SwiftUI
import MapKit

struct SMTMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MTMapView {
        let view = MTMapView(frame: .zero)
        view.baseMapType = .standard
        view.currentLocationTrackingMode = .onWithoutHeading
        view.showCurrentLocationMarker = true
        return view
    }
    
    func updateUIView(_ uiView: MTMapView, context: UIViewRepresentableContext<SMTMapView>) {
        
    }
}

struct SMTMapView_Preview: PreviewProvider {
    static var previews: some View {
        SMTMapView()
    }
}

struct MapView: UIViewRepresentable {
    
    @Binding var showMapAlert: Bool
    var annotations: [MKPointAnnotation]
    
    let locationManager = CLLocationManager()
    let mapView = MKMapView(frame: .zero)
    
    func makeUIView(context: Context) -> MKMapView {
        locationManager.delegate = context.coordinator
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("Updating")
        
        uiView.showsUserLocation = true
        uiView.userTrackingMode = .follow
        
        if annotations.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(annotations)
        }
    }
    
    ///Use class Coordinator method
    func makeCoordinator() -> LocationCoordinator {
        return LocationCoordinator(mapView: self)
    }
}


struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView(showMapAlert: .constant(false), annotations: [MKPointAnnotation.example])
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "우리집"
        annotation.subtitle = "백현마을 4단지"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.38932677417901, longitude: 127.1140780875495)
        return annotation
    }
}
