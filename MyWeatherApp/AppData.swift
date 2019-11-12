//
//  AppData.swift
//  MyWeatherApp
//
//  Created by Sarah Welty on 11/8/19.
//  Copyright © 2019 Sarah Welty. All rights reserved.
//


import Foundation

class AppData {
    
    static let cities = [
        "US":["Charlotte", "Chicago", "New York", "Miami", "San Francisco", "Baltimore", "Houston"],
        "UK":["London", "Bristol", "Cambridge", "Liverpool"],
        "AE":["Abu Dhabi", "Dubai", "Sharjah"],
        "JP":["Tokyo", "Kyoto", "Hashimoto", "Osaka"]
    ]
    
}

class Weather {
    var city: String?
    var region: String?
    var temperature: String?
    var temperatureMax: String?
    var temperatureMin: String?
    var description: String?
	var icon: String?
    var humidity: String?
    var windSpeed: String?
    var windDegree: String?
    var cloudiness: String?
    
	init(city: String, region: String, temperature: String, temperatureMax: String, temperatureMin: String, description: String, icon: String, humidity: String, windSpeed: String, windDegree: String, cloudiness: String) {
        self.city = city
        self.region = region
        self.temperature = temperature
        self.temperatureMax = temperatureMax
        self.temperatureMin = temperatureMin
        self.description = description
		self.icon = icon
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.windDegree = windDegree
        self.cloudiness = cloudiness
    }
}

class Forecast {
    var city: String?
	var dateTime: String?
    var temperature: String?
    var temperatureMax: String?
    var temperatureMin: String?
    var description: String?
	var icon: String?
    var humidity: String?


	init(city: String, dateTime: String, temperature: String, temperatureMax: String, temperatureMin: String, description: String, icon: String, humidity: String) {
        self.city = city
		self.dateTime = dateTime
        self.temperature = temperature
        self.temperatureMax = temperatureMax
        self.temperatureMin = temperatureMin
        self.description = description
		self.icon = icon
        self.humidity = humidity

    }
}

