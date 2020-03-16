//
//  SMKUserTrackingButton.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/16.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import SwiftUI
import MapKit

struct SMKUserTrackingButton: UIViewRepresentable {
    
    let trackingButton: MKUserTrackingButton
    init(mapView: MapViewProtocol) {
        self.trackingButton = MKUserTrackingButton(mapView: mapView.mkMapView)
    }

    func makeUIView(context: Context) -> MKUserTrackingButton {
        return trackingButton
    }
    
    func updateUIView(_ uiView: MKUserTrackingButton, context: Context) {
    }
}
