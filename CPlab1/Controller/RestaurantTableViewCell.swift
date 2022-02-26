//
//  RestaurantTableViewCell.swift
//  CPlab1
//
//  Created by Nikola Baci on 2/21/22.
//

import UIKit
import AlamofireImage

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantCategoryLabel: UILabel!
    @IBOutlet weak var restaurantRatingLabel: UILabel!
    @IBOutlet weak var restaurantPhoneLabel: UILabel!
    @IBOutlet weak var restaurantImageView: UIImageView!
    
    let noImageURL = "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg"
    
    func configure(with restaurant: Restaurant){
        restaurantNameLabel.text = restaurant.name
        restaurantCategoryLabel.text = restaurant.category
        restaurantRatingLabel.text = "Rating: \(restaurant.rating ?? 0)"
        restaurantPhoneLabel.text = restaurant.display_phone
        restaurantImageView.af.setImage(withURL: URL(string: restaurant.image_url ?? noImageURL)!)
    }
}
