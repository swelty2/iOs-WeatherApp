//
//  ViewController.swift
//  MyWeatherApp
//
//  Created by Sarah Welty on 11/8/19.
//  Copyright © 2019 Sarah Welty. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ViewController: UIViewController {
	var APIKEY = "&appid=2e58a8467dc5a6cc74e6392e6c5f0db6"
	@IBOutlet weak var tableView: UITableView!
	var keysArray = Array(AppData.cities.keys)
	var citiesArray = Array(AppData.cities.values)
	var citiesString : String?
	var selectedWeather : Weather?
	var index: Int?
	var region: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	//---- Function to set strings for VC, data from API call
    func setSelectedWeatherForCity(city: String?){
        print(city!)
        // change spaces out in city strings for '+' or else API call won't work
        let new = city?.replacingOccurrences(of: " ", with: "+")
        let location = "q=\(new!)"
        
	Alamofire.request("https://api.openweathermap.org/data/2.5/weather?\(location)\(APIKEY)", method: .get).responseJSON { (response) in
            if response.result.isSuccess{
                print("getWEather API Call Success!")
                //print(response.result.value!)
				//Use SwiftyJSON to extract data objects and pass bject to next VC
				let json = JSON(response.result.value!)//get response data object
				let temp = json["main"]["temp"].stringValue
				let tempMax = json["main"]["temp_max"].stringValue
				let tempMin = json["main"]["temp_min"].stringValue
                let humidity = json["main"]["humidity"].stringValue
				let description = json["weather"][0]["description"].stringValue
				let iconString = json["weather"][0]["icon"].stringValue
				let windDegree = json["wind"]["deg"].stringValue
                let windSpeed = json["wind"]["speed"].stringValue
				let cloudiness = json["clouds"]["all"].stringValue
                
                //set CurrentWeather object
				self.selectedWeather = Weather(city: city!, region: self.region!, temperature: temp, temperatureMax: tempMax, temperatureMin: tempMin, description: description, icon: iconString, humidity: humidity, windSpeed: windSpeed, windDegree: windDegree, cloudiness: cloudiness)
                //Segue to Current Weather
                self.performSegue(withIdentifier: "currentWeatherSegue", sender: self)
            } else{
                print("Error in setAllWeatherStrings--- ViewController.swift")
                
            }
        }//end of setSelectedWeatherForCity
    }//end of method
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "currentWeatherSegue"){
            print("performing segue to  Current Weather Page from ViewController.swift")
            let currentWeatherVC = segue.destination as! CurrentWeatherViewController
            
            currentWeatherVC.selectedWeather = self.selectedWeather!
		
			
        }else{
            print("Incorrect segue identifier- NO currentWeatherSegue detected")
        }
        
    }//end of prepare for segue
}//end of ViewController



extension ViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.keysArray[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.keysArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = citiesArray[indexPath.section][indexPath.row]
        return cell
    }
	
	
	
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        region = self.keysArray[indexPath.section]
        print("Region: \(region!)")
        let selected = citiesArray[indexPath.section][indexPath.row]
        print("Selected: \(selected)")
        setSelectedWeatherForCity(city: selected)
    }
    
}

