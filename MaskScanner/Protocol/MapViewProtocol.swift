//
//  MapViewProtocol.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/12.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewProtocol {
    var mapView: UIView { get }
    
    var viewModel: MaskStoresViewModel? { get set }
    var annotations: [MaskAnnotation]? { get set }
    
    func setRegion(_ region: MKCoordinateRegion, needUpdate:Bool, animated: Bool)
}

extension MapViewProtocol {
    func setRegion(_ region: MKCoordinateRegion, needUpdate:Bool, animated: Bool) { }
    
    var mkMapView: MKMapView? {
        return mapView as? MKMapView
    }
}
