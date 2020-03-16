//
//  CLLocation.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/16.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import MapKit

extension CLLocation {

    /// Get distance between two points
    ///
    /// - Parameters:
    ///   - from: first point
    ///   - to: second point
    /// - Returns: the distance in meters
    class func distance(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D) -> CLLocationDistance {
        let from = CLLocation(latitude: from.latitude, longitude: from.longitude)
        let to = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return to.distance(from: from)
    }
}
