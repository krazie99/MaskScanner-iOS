//
//  MaskAnnotation.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/16.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import MapKit

class MaskAnnotation: MKPointAnnotation {

    var identifier: String = "maskAnnotionIdentifier"
    
    var remainType: MaskRemainType = .empty
    var displayPriority: MKFeatureDisplayPriority = .defaultLow
    var color: UIColor = UIColor.gray
    
    static func make(from stores: [MaskStore]) -> [MaskAnnotation] {
        let annotations = stores.map { (store) -> MaskAnnotation in
            let annotation = MaskAnnotation()
            annotation.title = store.name
            annotation.subtitle = store.remainText
            annotation.coordinate = CLLocationCoordinate2DMake(store.lat, store.lng)
            
            annotation.remainType = store.remainType
            annotation.displayPriority = store.displayPriority
            annotation.color = store.color
            return annotation
        }
        return annotations
    }
}
