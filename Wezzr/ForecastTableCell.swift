//
//  ForecastTableCell.swift
//  Wezzr
//
//  Created by Dauren Omarov on 10.11.2021.
//

import UIKit

class ForecastTableCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconLabel: UIImageView!
    @IBOutlet weak var cellTempLabel: UILabel!
    
    static let reuseIdentifier = "ForecastTableCell"
    
    public func configure(with day: String, iconName: String, temp: String) {
        dayLabel.text = day
        iconLabel.image = UIImage(systemName: iconName)
        cellTempLabel.text = temp
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
