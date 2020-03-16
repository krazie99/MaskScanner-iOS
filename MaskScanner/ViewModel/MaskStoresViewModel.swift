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
    
    @Published var annotations: [MaskAnnotation]?
    @Published var showMapAlert = false
    
    @Published var isLoading = false
    @Published var canRefresh = false
    var isRefreshed = false
    
    var stores: [MaskStore]? {
        didSet {
            refreshAnnotations()
        }
    }
    
    var regionTuple: (lati: Double, lng: Double)?
    
    func requestMaskStoresByGeo() {
        let request = GeoStoresSRequest()
        if let regionTuple = regionTuple {
            request.lat = regionTuple.lati
            request.lng = regionTuple.lng
        }
        
        isLoading = true
        SNetwork.request(request) { [weak self] (response, error) in
            guard let self = self else { return }
            self.isRefreshed = true
            self.isLoading = false
            self.canRefresh = false
            
            guard let response = response as? GeoStoresSResponse else { return }
            self.stores = response.stores
        }
    }
    
    private func refreshAnnotations() {
        guard let stores = self.stores else {
            self.annotations = nil
            return
        }

        let maskAnnotations = MaskAnnotation.make(from: stores)
        if !maskAnnotations.isEmpty {
            self.annotations = maskAnnotations
        } else {
            self.annotations = nil
        }
    }
}
