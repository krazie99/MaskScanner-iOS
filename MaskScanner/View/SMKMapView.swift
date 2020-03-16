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
        
        let button = MKUserTrackingButton(mapView: mkMapView)
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        mkMapView.addSubview(button)
        
        let scale = MKScaleView(mapView: mkMapView)
        scale.legendAlignment = .trailing
        scale.translatesAutoresizingMaskIntoConstraints = false
        mkMapView.addSubview(scale)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: mkMapView.bottomAnchor, constant: -65),
            button.trailingAnchor.constraint(equalTo: mkMapView.trailingAnchor, constant: -13),
            scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
            scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
        
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("Updating")
        guard let annotations = annotations, viewModel?.isRefreshed ?? false else { return }
        viewModel?.isRefreshed.toggle()
        uiView.removeAnnotations(uiView.annotations)
        uiView.addAnnotations(annotations)
    }
    
    private func registerAnnotationViewClasses() {
        mkMapView.register(MaskAnnottationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mkMapView.register(MaskClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    
    ///Use class Coordinator method
    func makeCoordinator() -> LocationCoordinator {
        return LocationCoordinator(mapView: self, locationManager: CLLocationManager())
    }
    
    func setRegion(_ region: MKCoordinateRegion, needUpdate: Bool, animated: Bool) {
        viewModel?.regionTuple = (region.center.latitude, region.center.longitude)
        if needUpdate {
            mkMapView.setRegion(region, animated: animated)
            viewModel?.requestMaskStoresByGeo()
            viewModel?.canRefresh = false
        }
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
