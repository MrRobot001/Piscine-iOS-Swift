//
//  ListViewController.swift
//  Day05
//
//  Created by Bogdan DEOMIN on 2/10/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit
import MapKit

class ListViewController: UIViewController {

    private var latitude:CLLocationDegrees = 0
    private var longitude:CLLocationDegrees = 0
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ListTableViewCell
        cell.name.text = allPins[indexPath.row].pinTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        latitude = allPins[indexPath.row].latitude
        longitude = allPins[indexPath.row].longitude
        let destination = self.tabBarController?.viewControllers![0] as! MapViewController
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D  = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        destination.setRegion = region
        destination.otherReg = true
        self.tabBarController?.selectedViewController = destination
    }
    
}
