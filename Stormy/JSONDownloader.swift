//
//  JSONDownloader.swift
//  Stormy
//
//  Created by Izzy Ali on 30/06/2017.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class JSONDownloader    {
     //intiate network session to download data and configure it to be in JSON format
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init()  {
        self.init(configuration: .default)
    }
    
    
    typealias JSON = [String: Any]
    
    func jsonTask(with request: URLRequest, completionHander completion: @escaping (JSON?, DarkSkyError?) -> Void ) -> URLSessionDataTask {
        let task = session.dataTask(with: request)  {
            data, response, error in
            
            //convert to HTTP Response
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200   {
                
                if let data = data  {
                    //happy path
                    do  {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
                
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
}
