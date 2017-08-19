//
//  ViewController.swift
//  IOSMapaLocalization
//
//  Created by Carlos on 17/08/2017.
//  Copyright © 2017 Woowrale. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    private let METERS_50: Double = 50
    private let manager = CLLocationManager()
    
    private var distanceTotal: Double = 0
    private var firtsLocation: CLLocation?
    private var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest

        if(CLLocationManager.locationServicesEnabled()){
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        currentLocation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedWhenInUse){
            manager.startUpdatingLocation()
            mapView.showsUserLocation = true
        }else{
            manager.stopUpdatingLocation()
            mapView.showsUserLocation = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        defer {
            currentLocation = locations.last
        }

        if currentLocation == nil {
            distanceTotal = 0
            clearMapViewAnnotations()
            firtsLocation = locations.last
            let point: CLLocationCoordinate2D = createPoint(location: firtsLocation!)
            let pin: MKPointAnnotation = createPin(point: point, distance: distanceTotal)
            mapView.addAnnotation(pin)
            
            if let userLocation = locations.last {
                let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 1000)
                mapView.setRegion(viewRegion, animated: true)
            }
        }else{
            let distance = calculateDistance(initialLocation: firtsLocation!, finalLocation: currentLocation!)
            //print("Distance: ", distance)
            if(distance >= METERS_50){
                firtsLocation = currentLocation
                distanceTotal = distanceTotal + distance
                print("Total Distance: ", distanceTotal)
                let point: CLLocationCoordinate2D = createPoint(location: firtsLocation!)
                let pin: MKPointAnnotation = createPin(point: point, distance: distanceTotal)
                mapView.addAnnotation(pin)
            }
        }
    }
    
    func createPoint(location: CLLocation) -> CLLocationCoordinate2D{
        var point = CLLocationCoordinate2D()
            point.latitude = location.coordinate.latitude
            point.longitude = location.coordinate.longitude
        
        return point
    }
    
    func createPin(point: CLLocationCoordinate2D, distance: Double)->MKPointAnnotation{
        let pin = MKPointAnnotation()
            pin.title = "Position: [" + String(point.latitude) + ", " + String(point.longitude) + "]"
            pin.subtitle = "Distance: [" + String(distance) + "]"
            pin.coordinate = point
        
        return pin
    }
    
    func calculateDistance(initialLocation: CLLocation, finalLocation: CLLocation)->Double{
        var distance: Double = 0
        distance = initialLocation.distance(from: finalLocation)
        return distance
    }
    
    func clearMapViewAnnotations(){
        print("Total Annotations: ", mapView.annotations.count)
        if(mapView.annotations.count > 0){
            mapView.removeAnnotations(mapView.annotations)
        }
    }
    
    @IBAction func showNormal(_ sender: UIButton) {
        print("Normal")
        mapView.mapType = .standard
    }
    
    
    @IBAction func showSatelite(_ sender: UIButton) {
        print("Satelite")
        mapView.mapType = .satellite
    }
    
    
    @IBAction func showHibrido(_ sender: UIButton) {
        print("Hibrido")
        mapView.mapType = .hybrid
    }
}

