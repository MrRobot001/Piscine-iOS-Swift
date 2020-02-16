//
//  MapViewController.swift
//  Day05
//
//  Created by Bogdan DEOMIN on 2/10/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class custopPin: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var color: UIColor?
    
    init(pinTitle:String, pinSubTitle:String, location:CLLocationCoordinate2D, pinColor: UIColor) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
        self.color = pinColor
    }
}

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var SC: UISegmentedControl!
    
    var setRegion:MKCoordinateRegion = MKCoordinateRegion()
    var otherReg:Bool = false
    let locationManager  = CLLocationManager()
    var seeLocation: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        allPins.append(pin(pinTitle: "Unit Factory", pintSubTitle: "Unit city", latitude: 50.468834, longitude: 30.462163))
        allPins.append(pin(pinTitle: "Ocean Plaza", pintSubTitle: "Ukraine/Kiev/Ocean Plaaza", latitude: 50.413001, longitude: 30.522348))
        allPins.append(pin(pinTitle: "Maidan Nezalezhnosti", pintSubTitle: "Ukraine/Kiev/Maidan Nezalezhnosti", latitude: 50.450671, longitude: 30.523012))
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
        
        
        self.SC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.blue], for: .normal)
        self.SC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
        
        var color:Int = 0
        let colors = [UIColor](arrayLiteral: UIColor.yellow, UIColor.blue, UIColor.red)
        for pin in allPins{
            let createPin = custopPin(pinTitle: pin.pinTitle, pinSubTitle: pin.pintSubTitle, location: .init(latitude: pin.latitude, longitude: pin.longitude), pinColor: colors[color])
            self.mapView.addAnnotation(createPin)
            color = (color + 1) % 3
        }
        mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("Im here")
        let marker = MKMarkerAnnotationView()
        let myAnnot = annotation as? custopPin
        marker.markerTintColor = myAnnot?.color
        return marker
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D  = CLLocationCoordinate2D(latitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!)
        if (!otherReg) {
            setRegion = MKCoordinateRegion(center: myLocation, span: span)
        }
        else{
            otherReg = false
            mapView.setRegion(setRegion, animated: true)
        }
        if (seeLocation){
            mapView.setRegion(setRegion, animated: true)
        }
        self.mapView.showsUserLocation = true
    }
    
    
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
    
    @IBAction func localizationButton(_ sender: Any) {
        seeLocation = seeLocation ?  false : true
    }
    
}
