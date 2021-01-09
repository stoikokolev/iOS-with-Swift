//
//  LocationTableViewCell.swift
//  Bilbo's Diary
//
//  Created by Veronica Velkova on 9.10.20.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
//    func configure(_ location: Location) {
//        descriptionLabel.text = location.descriptionText
//        if let placemark = location.placemark {
//            addressLabel.text = """
//                    \(placemark.subThoroughfare ?? "") \(placemark.thoroughfare ?? "")
//                    \(placemark.locality ?? "") \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? "")
//                    """
//        } else {
//            addressLabel.text = String(format:
//            "Lat: %.8f, Long: %.8f", location.latitude,
//                                     location.longitude)
//        }
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
//        if selected {
//            backgroundColor = UIColor(named: "Color")
//        } else {
//            backgroundColor = UIColor(named: "CellBackground")
//        }
    }
}
