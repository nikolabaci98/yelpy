//
//  ViewController.swift
//  CPlab1
//
//  Created by Nikola Baci on 2/21/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var restaurantTableView: UITableView!
    
    private var restaurants = [Restaurant]() {
        didSet {
            restaurantTableView.reloadData()
        }
    }
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.requestLocation()
        
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantTableViewCell") as? RestaurantTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(with: restaurants[indexPath.row])
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        
        guard let lat = locations.last?.coordinate.latitude else {
            return
        }
        guard let long = locations.last?.coordinate.longitude else {
            return
        }
                
        RestaurantService.shared.fetchRestaurants(latitude: lat, longitude: long) { restaurants in
            self.restaurants = restaurants
        }
    }
}

