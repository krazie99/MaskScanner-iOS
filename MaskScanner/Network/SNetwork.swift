//
//  SNetwork.swift
//  MaskScanner
//
//  Created by Sean Choi on 2020/03/14.
//  Copyright © 2020 Sean Choi. All rights reserved.
//

import UIKit
import Alamofire

typealias SCompletion = (_ response: Codable?, _ error: Error?) -> Void

protocol DataRequestCancelable {
    func cancel()
}

extension DataRequest : DataRequestCancelable {
    func cancel() {
        task?.cancel()
    }
}

class SNetwork {
    
    static let domain : String = "https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1"
    
    @discardableResult
    static func request<T:Codable>(_ request: SRequest<T>, completion: @escaping SCompletion) -> DataRequestCancelable {
        return AF.request(request.url, method: request.method, parameters: request.parameters, encoding: JSONEncoding.default, headers: request.headers)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                processing(request, response: response, completion: completion)
            })
    }
    
    private static func processing<T:Codable>(_ request: SRequest<T>, response: AFDataResponse<Any>, completion: @escaping SCompletion) {
        var alertTitle : String?
        #if DEBUG
        alertTitle = request.path
        #endif
        
        switch response.result {
        case .success(let value):
            print ("response is \(value)")
            let data = try! JSONSerialization.data(withJSONObject: value)
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(response, nil)
            } catch let error {
                print ("error parsing get logs: \(error)")
                if request.ignoreErrorAlert == false {
                    AlertHelper.show(with: alertTitle, message: error.localizedDescription, completion: {
                        completion(nil, error)
                    })
                } else {
                    completion(nil, error)
                }
            }
        case .failure(let error):
            if request.ignoreErrorAlert == false {
                AlertHelper.show(with: alertTitle, message: error.localizedDescription, completion: {
                    completion(nil, error)
                })
            } else {
                completion(nil, error)
            }
        }
    }
}
