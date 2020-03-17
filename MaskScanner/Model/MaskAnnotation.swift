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
    
    let store: MaskStore
    init(store: MaskStore) {
        self.store = store
        super.init()
    }
    
    static func make(from stores: [MaskStore]) -> [MaskAnnotation] {
        let annotations = stores.map { (store) -> MaskAnnotation in
            let annotation = MaskAnnotation(store: store)
            annotation.title = store.name
            annotation.subtitle = store.remainText
            annotation.coordinate = CLLocationCoordinate2DMake(store.latitude, store.longitude)
            return annotation
        }
        return annotations
    }
}
