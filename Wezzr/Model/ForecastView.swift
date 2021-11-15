//
//  ForecastView.swift
//  Wezzr
//
//  Created by Dauren Omarov on 14.11.2021.
//

import UIKit

final class ForecastView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "ForecastView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    var day: String? {
        get { return dayLabel?.text }
        set { dayLabel.text = newValue }
    }

    var icon: UIImage? {
        get { return iconImage.image }
        set { iconImage.image = newValue }
    }
    
    var temperature: String? {
        get { return temperatureLabel?.text }
        set { temperatureLabel.text = newValue }
    }
}
