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
    @Binding var annotations: [MaskAnnotation]?
    
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
