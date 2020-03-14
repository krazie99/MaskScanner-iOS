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
    @Published var stores: [MaskStore]?
    
    @Published var locations: [MKPointAnnotation]?
    @Published var latiAndLng: (Double, Double)?
    
    @Published var showMapAlert = false
    
    func requestMaskStoresByGeo() { //(lati : Double, lng: Double) {
        let request = GeoStoresSRequest()
//        request.lat = lati
//        request.lng = lng
        SNetwork.request(request) { [weak self] (response, error) in
            guard let self = self, let response = response as? GeoStoresSResponse else { return }
            self.stores = response.stores
        }
    }
}
