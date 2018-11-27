//
//  MapViewController.swift
//  BAH_Application
//
//  Created by Bharmal, Hussain A on 11/24/18.
//  Copyright © 2018 BAH. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

<<<<<<< HEAD
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
=======
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var myMapView: MKMapView!
    var matchingItems: [MKMapItem] = []
>>>>>>> d485c3060d85019549c409701498bcf4d58e261e
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
<<<<<<< HEAD
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestLocation()
        }
        
//        mapView.delegate = self as? MKMapViewDelegate
//        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
        
    }
    
    
=======
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.requestLocation()
        }
        
        myMapView.delegate = self
        myMapView.showsUserLocation = true
        myMapView.userTrackingMode = .follow
        
        searchForGroceryStores()
        
    }
>>>>>>> d485c3060d85019549c409701498bcf4d58e261e

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
<<<<<<< HEAD
=======
    // MARK: - CLLocationManager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            myMapView.setRegion(region, animated: true)

        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func searchForGroceryStores() {
        let searchText = "grocery store"
        let request = MKLocalSearchRequest()
        request.region = myMapView.region
        request.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.updatePins()
        }
    }
    
    // parase an adress given a placemark
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
    // update pins
    func updatePins() {
        for item in matchingItems {
            print(item.placemark.title)
            let annotation = MKPointAnnotation()
            annotation.coordinate = item.placemark.coordinate
            annotation.title = item.placemark.title
            myMapView.addAnnotation(annotation)
        }
    }
    
>>>>>>> d485c3060d85019549c409701498bcf4d58e261e
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
<<<<<<< HEAD

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location:: (location)")
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: (error)")
    }
}
=======
>>>>>>> d485c3060d85019549c409701498bcf4d58e261e
