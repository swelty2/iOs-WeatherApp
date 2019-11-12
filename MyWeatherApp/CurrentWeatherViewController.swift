//
//  CurrentWeatherViewController.swift
//  MyWeatherApp
//
//  Created by Sarah Welty on 11/8/19.
//  Copyright © 2019 Sarah Welty. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CurrentWeatherViewController: UIViewController {


	@IBOutlet weak var temperatureField: UILabel!
	@IBOutlet weak var cityField: UILabel!
	
	@IBOutlet weak var temperatureMaxField: UILabel!
	@IBOutlet weak var descriptionField: UILabel!
	@IBOutlet weak var cloudinessField: UILabel!
	@IBOutlet weak var windDegreeField: UILabel!
	@IBOutlet weak var windSpeedField: UILabel!
	@IBOutlet weak var humidityField: UILabel!
	@IBOutlet weak var temperatureMinField: UILabel!
	
	@IBOutlet weak var iconImage: UIImageView!
	
	@IBAction func forecastButton(_ sender: Any) {
		//code for on forecast click
		
		//forecastSegue
	}
	
	
	//----- Variables for weather object to pass to VC
	var locationString: String?
	var temperatureString: String?
	var temperatureMaxString: String?
	var temperatureMinString: String?
	var descriptionString: String?
	var iconString: String?
	var humidityString: String?
	var windSpeedString: String?
	var windDegreeString: String?
	var cloudinessString: String?

	var selectedWeather: Weather?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        setAllStringValues()
        cityField.text = self.locationString!
        temperatureField.text = self.temperatureString!
        temperatureMaxField.text = self.temperatureMaxString!
        temperatureMinField.text = self.temperatureMinString!
        descriptionField.text = self.descriptionString!
        humidityField.text = self.humidityString!
        windSpeedField.text = self.windSpeedString!
        windDegreeField.text = self.windDegreeString!
        cloudinessField.text = self.cloudinessString!
        
	//----- API call to get the weather icon from iconString of current weather object
	
		
    }
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "forecastSegue"){
            print("performing segue to  FORECAST Page from CurrentWeatherViewController.swift")
            let forecastVC = segue.destination as! ForecastViewController
			//---- Set string vars on Forecast Page
			forecastVC.region = self.selectedWeather?.region
			forecastVC.cityString = self.selectedWeather?.city
        }else{
            print("Incorrect segue identifier")
        }
        
    }
	
    func setAllStringValues(){
        //Location string is "City, Region"
        self.locationString = "\(selectedWeather?.city! as! String), \(selectedWeather?.region as! String)"
        
        //convert temps from K to F
        let tempK = Float(selectedWeather?.temperature! as! String)
		let tempF = (tempK! * (9.0/5.0) - 459.67)
		
        self.temperatureString = "\(String(format: "%.01f", tempF)) F"
        
        let tempMaxK = Float(selectedWeather?.temperatureMax! as! String)
        let tempMaxF = tempMaxK! * (9.0/5.0) - 459.67
        self.temperatureMaxString = "\(String(format: "%.01f", tempMaxF)) F"
        
        let tempMinK = Float(selectedWeather?.temperatureMin! as! String)
        let tempMinF = tempMinK! * (9.0/5.0) - 459.67
        self.temperatureMinString = "\(String(format: "%.01f", tempMinF)) F"
        
        self.descriptionString = selectedWeather?.description as! String
        self.iconString = selectedWeather?.icon as! String

        self.humidityString = "\(selectedWeather?.humidity as! String) %"
        
        self.windSpeedString = "\(selectedWeather?.windSpeed as! String) miles/hr"
        //convert wind degree to fahrenheit
        let windDegreeK = Float(selectedWeather?.windDegree! as! String)
        let windDegreeF = windDegreeK! * (9.0/5.0) - 459.67
        self.windDegreeString = "\(String(format: "%.01f", windDegreeF)) degrees"
        
        let cloudiness = Int(selectedWeather?.cloudiness! as! String)
        self.cloudinessString = "\(cloudiness!) %"

		// The image to dowload
		let remoteImageURL = URL(string: "http://openweathermap.org/img/wn/\(iconString!)@2x.png")!
		 
		// Use Alamofire to download the image
		Alamofire.request(remoteImageURL).responseData { (response) in
				if response.error == nil {
					print(response.result)
					
		                 // Show the downloaded image:
		                 if let data = response.data {
								
							
		                     self.iconImage.image = UIImage(data: data)
		                 }
		             }
		        }
		}//end of setAllStrings()

}


