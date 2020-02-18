//
//  MapViewController.swift
//  Rush01
//
//  Created by Bogdan DEOMIN on 2/16/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit


import MapKit

import GoogleMaps
import GooglePlaces

import SwiftyJSON
import Alamofire

class MapViewController: UIViewController {
    
//    enum JSONError: String, Error {
//        case NoData = "ERROR: no data"
//        case ConversionFailed = "ERROR: conversion from JSON failed"
//    }
    
    var rectangle = GMSPolyline()
    
    var loadWay: Bool = false
    var firstPoint: GMSPlace?
    var secondPoint: GMSPlace?
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var zoomLevel: Float = 15.0
    
    let defaultLocation = CLLocation(latitude: 50.468983, longitude: 30.462065)
    
    var selectedPlace: GMSPlace?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        
        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        
        view.addSubview(mapView)
        mapView.isHidden = true
        
    }
    
    func createMarkers(){
        mapView.clear()
        let fstMarker = GMSMarker()
        let secMarker = GMSMarker()
        
        fstMarker.title = firstPoint?.name
        fstMarker.snippet = firstPoint?.formattedAddress
        fstMarker.position = CLLocationCoordinate2D(latitude: (firstPoint?.coordinate.latitude)!, longitude: (firstPoint?.coordinate.longitude)!)
        fstMarker.icon = GMSMarker.markerImage(with: .green)
        
        secMarker.title = secondPoint?.name
        secMarker.snippet = secondPoint?.formattedAddress
        secMarker.position = CLLocationCoordinate2D(latitude: (secondPoint?.coordinate.latitude)!, longitude: (secondPoint?.coordinate.longitude)!)
        
        let camera = GMSCameraPosition.camera(withLatitude: firstPoint!.coordinate.latitude, longitude: firstPoint!.coordinate.longitude, zoom: zoomLevel)
        mapView.camera = camera
        
        fstMarker.map = self.mapView
        secMarker.map = self.mapView
    }
    
    func createRoute() {
                
        let sLat = self.firstPoint?.coordinate.latitude
        let sLong = self.firstPoint?.coordinate.longitude
        
        let fLat = self.secondPoint?.coordinate.latitude
        let fLong = self.secondPoint?.coordinate.longitude
        
        let a_coordinate_string = "\(sLat!),\(sLong!)"
        let b_coordinate_string = "\(fLat!),\(fLong!)"
        
        print(a_coordinate_string)
        print(b_coordinate_string)
        
        let urlString = "https://maps.googleapis.com/maps/api/directions/json?origin=\(a_coordinate_string)&destination=\(b_coordinate_string)&mode=drive&key=AIzaSyA72X6hef7XBu18B4_XXXXXXXXXXXXXXXX&"
        
        Alamofire.request(urlString).responseJSON { response in
            
            do {
                let json = try JSON(data: response.data!)
//                print(json)
                let routes = json["routes"].arrayValue
                
//                print(routes)
                
                for route in routes
                {
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    let points = routeOverviewPolyline?["points"]?.stringValue
                    let path = GMSPath.init(fromEncodedPath: points!)
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 4
                    polyline.strokeColor = UIColor.red
                    polyline.map = self.mapView
                }
            } catch let error as NSError {
                print(error.debugDescription)
            } catch let error as SwiftyJSONError {
                print(error.rawValue)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.camera = camera
        } else {
            mapView.animate(to: camera)
        }
    }
    
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .restricted:
                print("Location access was restricted")
            case .denied:
                print("User denied access to location")
                mapView.isHidden = false
            case .notDetermined:
                print("Location status not determined")
            case .authorizedAlways: fallthrough
            case .authorizedWhenInUse:
                print("Location status is OK.")
            @unknown default:
                fatalError()
            }
        }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}
