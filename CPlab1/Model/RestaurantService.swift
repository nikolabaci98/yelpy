//
//  RestaurantService.swift
//  CPlab1
//
//  Created by Nikola Baci on 2/22/22.
//

import Foundation
import CoreLocation

class RestaurantService {
    
    static let shared = RestaurantService()
    
    func fetchRestaurants(latitude lat: CLLocationDegrees,
                          longitude long: CLLocationDegrees,
                          completion: @escaping(([Restaurant]) -> Void)){
        let apikey = "5-XIl-LruYdYazLsH8v7HRYkMJuInPmcuEGVsrouVLzenhXg-C4yiUyY3EL7eTQgndgxxpIuP5pizDw9IhO891scj6wtHqNrntwvTKP-AXXvqgGRW55xinHVQDgVYnYx"
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error \(String(describing: error))")
                return
            }
            guard let data = data else {
                print("Got no data")
                return
            }
            
            let decoder = JSONDecoder()
            var restaurants = [Restaurant]()
            do {
                let decodedData = try decoder.decode(RestaurantsList.self, from: data)
                for business in decodedData.businesses {
                    let restaurant = Restaurant(name: business.name,
                                                category: business.categories?[0]["title"],
                                                rating: business.rating,
                                                display_phone: business.display_phone,
                                                image_url: business.image_url)
                    restaurants.append(restaurant)
                }
                completion(restaurants)
            } catch {
                print(error)
                return
            }
        }
        task.resume()
    }
}
