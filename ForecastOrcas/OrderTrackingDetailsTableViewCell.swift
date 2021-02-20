//
//  OrderTrackingDetailsTableViewCell.swift
//  CountryFood
//
//  Created by mohamed hashem on 7/13/20.
//  Copyright © 2020 mohamed hashem. All rights reserved.
//

import UIKit

class OrderTrackingDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDegLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configurationUI(sectionWeather: WeatherModel.Sections) {
        cityNameLabel.text = sectionWeather.cityName ?? "--"
        windSpeedLabel.text = (sectionWeather.windSpeed ?? "--") + " KM/H"
        windDegLabel.text = (sectionWeather.windDeg ?? "--") + " ↑"
        tempLabel.text = (sectionWeather.temp ?? "--") + " °C"
        pressureLabel.text = (sectionWeather.pressure ?? "--") + " mbar"
        weatherDescriptionLabel.text = sectionWeather.description ?? "--"
    }
}
