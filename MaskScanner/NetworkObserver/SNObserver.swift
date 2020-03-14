//
//  SNObserver.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/14.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import SwiftUI

class SNObserver : ObservableObject{
    @Published var stores: [MaskStore]?
    
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
