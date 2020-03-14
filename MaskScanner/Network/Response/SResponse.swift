//
//  SResponse.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/14.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import UIKit

protocol SResponse : Codable {
    var count: Int { get }
}

extension SResponse {
    func isSuccess() -> Bool {
        return count > 0
    }
}
