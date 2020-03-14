//
//  SRequest.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/14.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import UIKit
import Alamofire

class SRequest<T:Codable> {
    
    var domain : String {
        return SNetwork.domain
    }
    
    var path : String? {
        return nil
    }
    
    var url : String {
        if let path = path {
            return domain + path
        }
        return domain
    }
    
    var method : HTTPMethod {
        return .get
    }
    
    var parameters : Parameters? {
        return nil
    }
    
    var headers : HTTPHeaders {
        return [.contentType("application/json"), .accept("application/json")]
    }
    
    var ignoreErrorAlert: Bool = false
}
