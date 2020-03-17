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
            guard let maskAnnotation = newValue as? MaskAnnotation else { return }
            clusteringIdentifier = "maskClusterIdentifier"
            
            canShowCallout = true
            
            let disclosureButton = UIButton(type: .detailDisclosure)
            disclosureButton.tintColor = UIColor(named: "buttonTextColor")
            rightCalloutAccessoryView = disclosureButton
            
            glyphImage = UIImage(named: "mask")
            markerTintColor = maskAnnotation.store.color
            displayPriority = maskAnnotation.store.displayPriority
        }
    }

}
