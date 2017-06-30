//
//  DarkSkyAPIClient.swift
//  Stormy
//
//  Created by Izzy Ali on 30/06/2017.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation

class DarkSkyAPIClient {
    
    //MARK: Properties
    fileprivate let darkSkyApiKey = "b574773056392da27430d15dd605b674"
    lazy var baseUrl: URL = {
        return URL(string: "https://api.darksky.net/forecast/\(self.darkSkyApiKey)/")!
    }()// means called immediately (), recall that lazy is called sometime after init
    let downloader = JSONDownloader()
    
    typealias CurrentWeatherCompletionHandler = (CurrentWeather?, DarkSkyError?) -> Void
    
    func getCurrentWeather(at coordinate: Coordinate, completionHandler completion: @escaping CurrentWeatherCompletionHandler) {
        
        guard let url = URL(string: coordinate.description, relativeTo: baseUrl) else {
            completion(nil, .invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = downloader.jsonTask(with: request) {
            json, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let currentWeatherJson = json["currently"] as? [String: Any],
                    let currentWeather = CurrentWeather(json: currentWeatherJson) else {
                        completion(nil, .jsonParsingFailure)
                        return
                }
                
                completion(currentWeather, nil)
            }
        }
        
        task.resume()
    }
}
