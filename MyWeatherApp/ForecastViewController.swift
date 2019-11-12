//
//  ForecastViewController.swift
//  MyWeatherApp
//
//  Created by Sarah Welty on 11/8/19.
//  Copyright © 2019 Sarah Welty. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class ForecastViewController: UIViewController {

	@IBOutlet weak var forecastTableView: UITableView!
	@IBOutlet weak var cityLabel: UILabel!
	var APIKEY = "&appid=2e58a8467dc5a6cc74e6392e6c5f0db6"

	var dateTimeString:String?
	var temperatureString:String?
	var maxTempString:String?
	var minTempString:String?
	var humidityString:String?
	var descriptionString: String?


	
	var weatherObj: Weather?
	var forecastArray: [Forecast?] = []
	var iconArray: [String?] = []
	var iconImageArray: [String?] = []
	var cityString: String?
	var region: String?
	var countryCode: String?
	
	
	/*
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
	*/
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		let cellNib = UINib(nibName: "CustomTableViewCell", bundle: nil)
		forecastTableView.register(cellNib, forCellReuseIdentifier: "myCell")
			   let location = "q=\(cityString!),\(region!)"
		self.cityLabel.text = "\(cityString!), \(region!)"

		if (cityString == "" || cityString == nil){
			print("ERROR- no city string passed to FORECASTVC-- ViewDidLoad ForecastVC")
		} else {
			Alamofire.request("https://api.openweathermap.org/data/2.5/forecast?\(location)\(APIKEY)", method: .get).responseJSON { (response) in
            if response.result.isSuccess{
				print("Forecast API SUCCESS")
                print(response.result.value!)
				//USE SwiftyJSON API here to extract json objects needed
				let json = JSON(response.result.value!)//get response data object
				//print("City INDEX 0 = \(json["city"]["name"].string)")
				self.cityString = json["city"]["name"].string
				//self.temperatureString = json["list"]["list.main"]["list.main.temp"].string
				
				//get each object from JSON response and store in list
				let list: Array<JSON> = json["list"].arrayValue
				//Create and store forecast objects from list
				let index = 5
				for i in (1...index) {
				
				let forecastObj1 = Forecast(city: self.cityString!,
											dateTime: list[i]["dt_txt"].stringValue,
											temperature: list[i]["main"]["temp"].stringValue,
						
											temperatureMax: list[i]["main"]["temp_max"].stringValue,
						
											temperatureMin: list[i]["main"]["temp_min"].stringValue,
						
											description: list[i]["weather"][0]["description"].stringValue,
						
						icon: list[i]["weather"][0]["icon"].stringValue,
						
						humidity: list[i]["main"]["humidity"].stringValue)
					
				self.forecastArray.append(forecastObj1)
				self.iconArray.append(list[i]["weather"]["icon"].stringValue)
								}
				
				self.forecastTableView.reloadData()
				

			}//end API request
			
			
		}//end else
		
		
		
    }
}
}

	

extension ForecastViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return forecastArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = forecastTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell
		
		if (forecastArray.count == 0) {
			cell.dateTimeLabel.text = ""
				cell.descriptionLabel.text = ""
				cell.humidityLabel.text = ""
				cell.maxTempLabel.text = ""
				cell.minTempLabel.text = ""
				cell.temperatureLabel.text = ""
		}
		else {
			cell.dateTimeLabel.text = forecastArray[indexPath.row]!.dateTime
			cell.descriptionLabel.text = forecastArray[indexPath.row]!.description
			//forecastArray[indexPath.row]!.description
			cell.humidityLabel.text = forecastArray[indexPath.row]!.humidity
			//cell.iconImage.image = ""
			//convert temps from K to F
			var tempK = Float(forecastArray[indexPath.row]!.temperatureMax as! String)
			var tempF = (tempK! * (9.0/5.0) - 459.67)
			cell.maxTempLabel.text = "\(String(format: "%.01f", tempF)) F"
			
			tempK = Float(forecastArray[indexPath.row]!.temperatureMin as! String)
			tempF = (tempK! * (9.0/5.0) - 459.67)
			cell.minTempLabel.text = "\(String(format: "%.01f", tempF)) F"
			
			
			tempK = Float(forecastArray[indexPath.row]!.temperature as! String)
			tempF = (tempK! * (9.0/5.0) - 459.67)
			cell.temperatureLabel.text = "\(String(format: "%.01f", tempF))"
			
			// The image to dowload
			let iconString = forecastArray[indexPath.row]!.icon
			print("Icon string passed is: \(forecastArray[indexPath.row]!.icon!)")
			
			
			let remoteImageURL = URL(string: "http://openweathermap.org/img/wn/\(iconString!)@2x.png")!
				 
				// Use Alamofire to download the image
				Alamofire.request(remoteImageURL).responseData { (response) in
						if response.error == nil {
							print(response.result)
							
								 // Show the downloaded image:
								 if let data = response.data {
									
									cell.iconImage.image = UIImage(data: data)
								 }
							 }
						}
	
		}
		
		return cell
	}
	
	
}

extension ForecastViewController: UITableViewDelegate {
	
}
