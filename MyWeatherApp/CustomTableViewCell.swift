//
//  CustomTableViewCell.swift
//  MyWeatherApp
//
//  Created by Sarah Welty on 11/10/19.
//  Copyright © 2019 Sarah Welty. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

	@IBOutlet weak var dateTimeLabel: UILabel!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var maxTempLabel: UILabel!
	@IBOutlet weak var minTempLabel: UILabel!
	@IBOutlet weak var humidityLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var iconImage: UIImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
