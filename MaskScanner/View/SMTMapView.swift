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
    var locationManager: CLLocationManager? = nil
    
    var viewModel: MaskStoresViewModel?
    @Binding var annotations: [MKPointAnnotation]?
    
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
        //다음맵뷰는 LocationManager을 사용하지 않는다
        mtMapView.delegate = context.coordinator
        return mtMapView
    }
    
    func updateUIView(_ uiView: MTMapView, context: Context) {
        print("Updating")
    }
    
    ///Use class Coordinator method
    func makeCoordinator() -> LocationCoordinator {
        return LocationCoordinator(mapView: self)
    }
}

struct SMTMapView_Preview: PreviewProvider {
    static var previews: some View {
        SMTMapView(viewModel: MaskStoresViewModel(), annotations: .constant([MKPointAnnotation.example]))
    }
}

extension LocationCoordinator: MTMapViewDelegate {
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        let currentLocationPointGeo = location.mapPointGeo()
        print("MTMapView updateCurrentLocation (\(currentLocationPointGeo.latitude)), \(currentLocationPointGeo.longitude) accuracy (\(accuracy))")
        
        mapView.setMapCenter(MTMapPoint(geoCoord: currentLocationPointGeo), zoomLevel: 1, animated: true)
        self.mapView.viewModel?.regionTuple = (currentLocationPointGeo.latitude, currentLocationPointGeo.longitude)
    }
    
    func mapView(_ mapView: MTMapView!, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView updateDeviceHeading (\(headingAngle))) degrees")
    }
}
