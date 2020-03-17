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
    
    @Published var hasSelectedAnnotations: Bool = false
    var selectedAnnotations: [MaskAnnotation]? {
        didSet {
            if let selectedAnnotations = selectedAnnotations, !selectedAnnotations.isEmpty {
                hasSelectedAnnotations = true
            } else {
                hasSelectedAnnotations = false
            }
        }
    }
    
    var selectedStores: [MaskStore] {
        guard let annotations = self.selectedAnnotations else { return [] }
        var stores: [MaskStore] = []
        for annotation in annotations {
            stores.append(annotation.store)
        }
        return stores
    }
    
    @Published var hasSelectedAnnotation: Bool = false
    var selectedAnnotation: MaskAnnotation? {
        didSet {
            self.selectedStore = self.selectedAnnotation?.store
            hasSelectedAnnotation = self.selectedStore != nil
        }
    }
    
    @Published var selectedStore: MaskStore?
    
    var regionTuple: (lati: Double, lng: Double)?
    var stores: [MaskStore]? {
        didSet {
            refreshAnnotations()
        }
    }
    
    @Published var showMapAlert = false
    
    @Published var isLoading = false
    @Published var canRefresh = false
    var isRefreshed = false
    
    
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
