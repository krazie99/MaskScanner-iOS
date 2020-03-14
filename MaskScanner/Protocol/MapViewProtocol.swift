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
    var locationManager: CLLocationManager? { get set }
    var viewModel: MaskStoresViewModel? { get set }
    
    func setRegion(_ region: MKCoordinateRegion, animated: Bool)
}

extension MapViewProtocol {
    func setRegion(_ region: MKCoordinateRegion, animated: Bool) { }
}
