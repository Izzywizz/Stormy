//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 2/15/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: Properties
    fileprivate let darkSkyApiKey = "b574773056392da27430d15dd605b674"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentWeather = CurrentWeather(temperature: 85.0, humidity: 0.8, precipitationProbability: 0.1, summary: "Hot!", icon: "clear-day")
        let currentWeatherViewModel = CurrentWeatherViewModel(model: currentWeather)
        
        displayWeather(using: currentWeatherViewModel)
        
        let baseUrl = URL(string: "https://api.darksky.net/forecast/\(darkSkyApiKey)/")
        guard let forcasetUrl = URL(string: "37.8267,-122.4233", relativeTo: baseUrl) else  { return }
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let request = URLRequest(url: forcasetUrl)
        
        print("Log before request on main thread")
        
        let dataTask = session.dataTask(with: request) { data, response, error in
        //background thread, the closure is the callback mechanism
            print("log inside completion handler")
        }
        
        dataTask.resume()
        print("log after resume")
    }
    
    func displayWeather(using viewModel: CurrentWeatherViewModel)  {
        currentTemperatureLabel.text = viewModel.temperature
        currentHumidityLabel.text = viewModel.humidity
        currentPrecipitationLabel.text = viewModel.precipitationProbablity
        currentSummaryLabel.text = viewModel.summary
        currentWeatherIcon.image = viewModel.icon
    }

}
















