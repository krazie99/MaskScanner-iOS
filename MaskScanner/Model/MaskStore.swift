//
//  MaskStore.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/14.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import Foundation
import MapKit

enum MaskRemainType {
    case plenty
    case some
    case few
    case empty
    
    var text: String {
        switch self {
        case .plenty:
            return "30개 이상 100개미만"
        case .some:
            return "2개 이상 30개 미만"
        case .few:
            return "1개 이하"
        case .empty:
            return "판매중지"
        }
    }
    
    var displayPriority: MKFeatureDisplayPriority {
        switch self {
        case .plenty:
            return .required
        case .some:
            return .defaultHigh
        case .few:
            return .defaultLow
        case .empty:
            return .defaultLow
        }
    }
    
    var color: UIColor {
        switch self {
        case .plenty:
            return UIColor(named: "greenMaskColor") ?? UIColor.green
        case .some:
            return UIColor(named: "yellowMaskColor") ?? UIColor.yellow
        case .few:
            return UIColor(named: "redMaskColor") ?? UIColor.red
        case .empty:
            return UIColor.gray
        }
    }
}

// MARK: - Mask Store
struct MaskStore: Codable, Identifiable {
    var id: Int {
        return name.hashValue
    }
    
    let code, name, addr, type: String
    let lat, lng: AnyDoubleValue?
    let stockAt, remainStat, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case code, name, addr, type, lat, lng
        case stockAt = "stock_at"
        case remainStat = "remain_stat"
        case createdAt = "created_at"
    }
}

extension MaskStore {
    var latitude: Double {
        return lat?.value ?? 0
    }
    
    var longitude: Double {
        return lng?.value ?? 0
    }
    
    var remainType: MaskRemainType {
        if let remainStat = remainStat {
            if remainStat == "plenty" {
                return .plenty
            } else if remainStat == "some" {
                return .some
            } else if remainStat == "few" {
                return .few
            }
        }
        return .empty
    }
    
    var remainText: String {
        return remainType.text
    }
    
    var displayPriority: MKFeatureDisplayPriority {
        return remainType.displayPriority
    }
    
    var color: UIColor {
        return remainType.color
    }
}

/*
 code*    string
 식별 코드

 name*    string
 이름

 addr*    string
 주소

 type*    string
 판매처 유형[약국: '01', 우체국: '02', 농협: '03']

 lat*    number($float)
 위도

 lng*    number($float)
 경도

 stock_at*    string($YYYY/MM/DD HH:mm:ss)
 입고시간

 remain_stat*    string
 재고 상태[100개 이상(녹색): 'plenty' / 30개 이상 100개미만(노랑색): 'some' / 2개 이상 30개 미만(빨강색): 'few' / 1개 이하(회색): 'empty' / 판매중지: 'break']

 created_at*    string($YYYY/MM/DD HH:mm:ss)
 데이터 생성 일자
 */
