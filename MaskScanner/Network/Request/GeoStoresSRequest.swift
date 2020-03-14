//
//  GeoStoresSRequest.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/14.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import UIKit
import Alamofire

final class GeoStoresSRequest: SRequest<GeoStoresSResponse> {
    
    override var path: String {
        return "/storesByGeo/json?lat=\(lat)&lng=\(lng)&m=\(meter)"
    }
    
    // MARK: - Parameters
    //위도(wgs84 좌표계) / 최소:33.0, 최대:43.0
    var lat: Double = 37.38932677417901
    //경도(wgs84 표준) / 최소:124.0, 최대:132.0
    var lng: Double = 127.1140780875495
    //반경(미터) / 최대 5000(5km)까지 조회 가능
    var meter : Int = 1000
}
