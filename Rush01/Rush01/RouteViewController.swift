//
//  RouteViewController.swift
//  Rush01
//
//  Created by Bogdan DEOMIN on 2/16/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMapsBase

class RouteViewController: UIViewController {
    
    @IBOutlet weak var fstSB: UISearchBar!
    @IBOutlet weak var secSB: UISearchBar!
    
    var fstresultsViewController: GMSAutocompleteResultsViewController?
    var secresultsViewController: GMSAutocompleteResultsViewController?
    var fstSearchController: UISearchController?
    var secSearchController: UISearchController?
    
    var firstPlace:GMSPlace?
    var secondPlace:GMSPlace?
    
    var firstInput: Bool = false
    var secondInput: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fstresultsViewController = GMSAutocompleteResultsViewController()
        fstresultsViewController?.delegate = self
        secresultsViewController = GMSAutocompleteResultsViewController()
        secresultsViewController?.delegate = self
        
        fstSearchController = UISearchController(searchResultsController: fstresultsViewController)
        fstSearchController?.searchResultsUpdater = fstresultsViewController
        secSearchController = UISearchController(searchResultsController: secresultsViewController)
        secSearchController?.searchResultsUpdater = secresultsViewController
        
        fstSB.addSubview((fstSearchController?.searchBar)!)
        secSB.addSubview((secSearchController?.searchBar)!)
        
        //view.addSubview(subView)
        fstSearchController?.searchBar.sizeToFit()
        fstSearchController?.hidesNavigationBarDuringPresentation = false
        secSearchController?.searchBar.sizeToFit()
        secSearchController?.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
    }
    
    @IBAction func swapCoordinate(_ sender: Any) {
        if firstInput || secondInput {
            if let fst = firstPlace {
                if let sec = secondPlace {
                    fstSearchController?.searchBar.text = "\(sec.name!)"
                }else{
                    fstSearchController?.searchBar.text = ""
                }
                secSearchController?.searchBar.text = "\(fst.name!)"
            }else{
                if let sec = secondPlace {
                    fstSearchController?.searchBar.text = "\(sec.name!)"
                    secSearchController?.searchBar.text = ""
                }
                
            }
            let tempGMSPlace: GMSPlace? = firstPlace
            firstPlace = secondPlace
            secondPlace = tempGMSPlace
        }
        
    }
    
        @IBAction func cleanInput(_ sender: Any) {
            firstInput = false
            secondInput = false
            firstPlace = nil
            secondPlace = nil
            
            fstSearchController?.searchBar.text = ""
            secSearchController?.searchBar.text = ""
        }
        
        
        @IBAction func routeMe(_ sender: Any) {
            if (firstInput && secondInput) {
                let destination = self.tabBarController?.viewControllers![0] as! MapViewController
                destination.firstPoint = firstPlace
                destination.secondPoint = secondPlace
                destination.loadWay = true
                destination.createMarkers()
                destination.createRoute()
                self.tabBarController?.selectedViewController = destination
            }
            else {
                print("You should input two place")
            }
        }
        
    }
    
    
    // Handle the user's selection.
    extension RouteViewController: GMSAutocompleteResultsViewControllerDelegate {
        
        func resultsController(_ resultsController: GMSAutocompleteResultsViewController, didAutocompleteWith place: GMSPlace) {
            
            if fstSearchController!.isActive {
                firstPlace = place
                fstSearchController?.isActive = false
                firstInput = true
                
                fstSearchController?.searchBar.text = ""
                if let namePlace = place.name {
                    fstSearchController?.searchBar.text = (fstSearchController?.searchBar.text)! + "\(namePlace)"
                }
                else {
                    fstSearchController?.searchBar.text = (fstSearchController?.searchBar.text)! + "\(place.coordinate)"
                }
            }
            if secSearchController!.isActive {
                secondPlace = place
                secSearchController?.isActive = false
                secondInput = true
                
                secSearchController?.searchBar.text = ""
                if let namePlace = place.name {
                    secSearchController?.searchBar.text = (secSearchController?.searchBar.text)! + "\(namePlace)"
                }
                else {
                    secSearchController?.searchBar.text = (secSearchController?.searchBar.text)! + "\(place.coordinate)"
                }
            }
            print("Location \(place.coordinate)")
            // Do something with the selected place.
        }
        
        func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                               didFailAutocompleteWithError error: Error){
            // TODO: handle the error.
            print("Error: ", error.localizedDescription)
        }
        
}
