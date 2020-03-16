//
//  AnyValue.swift
//  Tickr
//
//  Created by krazie99 on 06/04/2019.
//  Copyright © 2019 tickr. All rights reserved.
//

import UIKit

enum AnyIntValue: Codable {
    case int(Int)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            if let n = Int(x) {
                self = .int(n)
            } else {
                self = .int(0)
            }
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .int(x)
            return
        }
        throw DecodingError.typeMismatch(AnyIntValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AnyIntValue"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .int(let x):
            try container.encode(x)
        }
    }
    
    var value : Int {
        switch self {
        case .int(let ii):
            return ii
        }
    }
}

enum AnyDoubleValue: Codable {
    case double(Double)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            if let n = Double(x) {
                self = .double(n)
            } else {
                self = .double(0)
            }
            return
        }
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        throw DecodingError.typeMismatch(AnyDoubleValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AnyDoubleValue"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        }
    }
    
    var value : Double {
        switch self {
        case .double(let ii):
            return ii
        }
    }
}

enum AnyBoolValue: Codable {
    case boolean(Bool)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(String.self) {
            self = .boolean(x == "Y" ? true : false)
            return
        }
        if let x = try? container.decode(Int.self) {
            self = .boolean(x == 1 ? true : false)
            return
        }
        if let x = try? container.decode(Bool.self) {
            self = .boolean(x)
            return
        }
        throw DecodingError.typeMismatch(AnyBoolValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for AnyBoolValue"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .boolean(let x):
            try container.encode(x)
        }
    }
    
    var value : Bool {
        switch self {
        case .boolean(let ii):
            return ii
        }
    }
}
