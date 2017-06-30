//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 2/15/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let client = DarkSkyAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeather()
    }
    
    
    
    func displayWeather(using viewModel: CurrentWeatherViewModel)  {
        currentTemperatureLabel.text = viewModel.temperature
        currentHumidityLabel.text = viewModel.humidity
        currentPrecipitationLabel.text = viewModel.precipitationProbablity
        currentSummaryLabel.text = viewModel.summary
        currentWeatherIcon.image = viewModel.icon
    }

    @IBAction func getCurrentWeather() {
        toggleRefreshAnimation(on: true)
        
        let coordinate = Coordinate(latitude: 37.8267, longitude: -122.4333)

        client.getCurrentWeather(at: coordinate) { [unowned self]
            currentWeather, error in
    
            if error == nil {
                if let currentWeather = currentWeather  {
                    let viewModel = CurrentWeatherViewModel(model: currentWeather)
                    self.displayWeather(using: viewModel)
                    self.toggleRefreshAnimation(on: false)
                }
            } else {
                let alertViewController = UIAlertController(title: "Error Received", message: "There has been an error with the app \(error)", preferredStyle: .alert)
                let dismiss = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                alertViewController.addAction(dismiss)
            }
        }
    }
    
    func toggleRefreshAnimation(on: Bool) {
        refreshButton.isHidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
















