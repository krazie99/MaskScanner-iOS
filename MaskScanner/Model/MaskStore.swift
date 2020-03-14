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
    let lat, lng: Double
    let stockAt, remainStat, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case code, name, addr, type, lat, lng
        case stockAt = "stock_at"
        case remainStat = "remain_stat"
        case createdAt = "created_at"
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
