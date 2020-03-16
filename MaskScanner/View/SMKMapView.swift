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
    @Binding var annotations: [MaskAnnotation]?
    
    var viewModel: MaskStoresViewModel?
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
        registerAnnotationViewClasses()
        mkMapView.delegate = context.coordinator
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("Updating")
        if annotations?.count ?? 0 != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            if let annotations = annotations {
                uiView.addAnnotations(annotations)
            }
        }
    }
    
    private func registerAnnotationViewClasses() {
        mkMapView.register(MaskAnnottationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mkMapView.register(MaskClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    
    ///Use class Coordinator method
    func makeCoordinator() -> LocationCoordinator {
        return LocationCoordinator(mapView: self, locationManager: CLLocationManager())
    }
    
    func setRegion(_ region: MKCoordinateRegion, animated: Bool) {
        mkMapView.setRegion(region, animated: animated)
        viewModel?.regionTuple = (region.center.latitude, region.center.longitude)
    }
}

struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        SMKMapView(annotations: .constant([MKPointAnnotation.example]), viewModel: MaskStoresViewModel())
    }
}

extension MKPointAnnotation {
    static var exmpleregionTuple = (37.38932677417901, 127.1140780875495)
    static var example: MaskAnnotation {
        let annotation = MaskAnnotation()
        annotation.title = "서울시청"
        annotation.subtitle = "테스트"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.56638, longitude: 126.977715)
        return annotation
    }
}
