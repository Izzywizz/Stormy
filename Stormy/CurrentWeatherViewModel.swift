//
//  CurrentWeatherViewModel.swift
//  Stormy
//
//  Created by Izzy Ali on 29/06/2017.
//  Copyright © 2017 Treehouse. All rights reserved.
//

//Its just going to be a simple object that formats data

import UIKit

struct CurrentWeatherViewModel {
    let temperature: String
    let humidity: String
    let precipitationProbablity: String
    let summary: String
    let icon: UIImage
    
    init(model: CurrentWeather) {
        
        let roundedTemperature = Int(model.temperature)
        self.temperature = "\(roundedTemperature)º"
        
        let humidityPercentage = Int(model.humidity * 100)
        self.humidity = "\(humidityPercentage)%"
        
        let precipPercentValue = Int(model.precipitationProbability * 100)
        self.precipitationProbablity = "\(precipPercentValue)%"
        
        self.summary = model.summary
        
        let weatherIcon = WeatherIcon(iconString: model.icon)
        self.icon = weatherIcon.image
    }
}
