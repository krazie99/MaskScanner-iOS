//
//  MaskStoresViewModel.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/14.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import SwiftUI
import MapKit

class MaskStoresViewModel: ObservableObject {
    @Published var stores: [MaskStore]? {
        didSet {
            refreshAnnotations()
        }
    }
    
    @Published var regionTuple: (lati: Double, lng: Double)?
    @Published var annotations: [MKPointAnnotation]?
    
    @Published var showMapAlert = false
    
    func requestMaskStoresByGeo() {
        let request = GeoStoresSRequest()
        if let regionTuple = regionTuple {
            request.lat = regionTuple.lati
            request.lng = regionTuple.lng
        }
        SNetwork.request(request) { [weak self] (response, error) in
            guard let self = self, let response = response as? GeoStoresSResponse else { return }
            self.stores = response.stores
        }
    }
    
    private func refreshAnnotations() {
        guard let stores = self.stores else {
            self.annotations = nil
            return
        }
        
        var annotationsTemp = [MKPointAnnotation]()
        for store in stores {
            let annotation = MKPointAnnotation()
            annotation.title = store.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: store.lat, longitude: store.lng)
            annotationsTemp.append(annotation)
        }
        
        if !annotationsTemp.isEmpty {
            self.annotations = annotationsTemp
        } else {
            self.annotations = nil
        }
    }
}
