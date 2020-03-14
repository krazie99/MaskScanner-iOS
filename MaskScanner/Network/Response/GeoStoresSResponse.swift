//
//  GeoStoresSResponse.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/14.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import UIKit

// MARK: - MaskStores
struct GeoStoresSResponse: SResponse {
    var count: Int
    let stores: [MaskStore]?
}
