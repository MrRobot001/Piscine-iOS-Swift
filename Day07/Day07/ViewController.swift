//
//  ViewController.swift
//  Day07
//
//  Created by Bogdan DEOMIN on 2/13/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import UIKit
import RecastAI
import ForecastIO
import CoreLocation
class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!

    var recastClient: RecastAIClient?
    var forecastClient: DarkSkyClient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.autocorrectionType = .no
        self.recastClient = RecastAIClient(token: "1ece092e8b01d86eaabf8c949df65b9f")
        self.forecastClient = DarkSkyClient(apiKey: "89886873d0f5cbfcb8375edc4aa1df24")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressButton(_ sender: UIButton) {
        let inputText = textField.text!
        if inputText == "" {
            self.displayAlert(message: "Input something")
        }
        else {
            self.recastClient?.textRequest(inputText, successHandler: {
                resp in
                guard let location = resp.get(entity: "location") else {
                    self.displayAlert(message: "Can't find city")
                    return
                }
                guard let latitude = location["lat"] else {
                    self.displayAlert(message: "Latutude missing")
                    return
                }
                guard let longitude = location["lng"] else {
                    self.displayAlert(message: "Longitude missing")
                    return
                }
                
                let coordinates = CLLocationCoordinate2D(latitude: latitude as! CLLocationDegrees, longitude: longitude as! CLLocationDegrees)
                
                self.forecastClient!.language = .english
                self.forecastClient!.getForecast(location: coordinates) {
                    res in
                    
                    switch res {
                    case .success(let curForcast, _):
                        guard let weather = curForcast.currently?.summary else {self.displayAlert(message: "Data not found"); return}
                        guard let temp = curForcast.currently?.temperature else {self.displayAlert(message: "Data not found"); return}
                        DispatchQueue.main.async {
                            self.label.text = "Temperature: \(Int((temp - 32) * 5 / 9)), Weather: \(weather)"
                        }
                    case .failure(_):
                        self.displayAlert(message: "Error")
                    }
                }
            }, failureHandle: {
                (err) in
                print(err.localizedDescription)
            })
        }
    }
}

extension UIViewController {
    func displayAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

