//
//  MaskStore.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/14.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import Foundation

// MARK: - Mask Store
struct MaskStore: Codable {
    let code, name, addr, type: String
    let lat, lng: Int
    let stockAt, remainStat, createdAt: String

    enum CodingKeys: String, CodingKey {
        case code, name, addr, type, lat, lng
        case stockAt = "stock_at"
        case remainStat = "remain_stat"
        case createdAt = "created_at"
    }
}
