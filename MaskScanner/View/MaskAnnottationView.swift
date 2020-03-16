//
//  MaskAnnottationView.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/16.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import UIKit
import MapKit

class MaskAnnottationView: MKMarkerAnnotationView {

    override var annotation: MKAnnotation? {
        willSet {
            guard let maskAnnotation = newValue as? MaskAnnotaion else { return }
            clusteringIdentifier = "maskClusterIdentifier"
            
            canShowCallout = true
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            glyphImage = UIImage(named: "mask")
            markerTintColor = maskAnnotation.color
            displayPriority = maskAnnotation.displayPriority
        }
    }

}
