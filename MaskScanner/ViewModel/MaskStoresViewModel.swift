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
    
    @Published var annotations: [MaskAnnotaion]?
    @Published var showMapAlert = false
    
    var stores: [MaskStore]? {
        didSet {
            refreshAnnotations()
        }
    }
    
    var regionTuple: (lati: Double, lng: Double)? {
        didSet {
            requestMaskStoresByGeo()
        }
    }
    
    private func requestMaskStoresByGeo() {
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

        let maskAnnotations = MaskAnnotaion.make(from: stores)
        
        if !maskAnnotations.isEmpty {
            self.annotations = maskAnnotations
        } else {
            self.annotations = nil
        }
    }
}
