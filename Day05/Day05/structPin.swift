//
//  structPin.swift
//  Day05
//
//  Created by Bogdan DEOMIN on 2/11/20.
//  Copyright © 2020 Bogdan. All rights reserved.
//

import Foundation
import MapKit

//enum pin: custopPin {
//    case first = custopPin(pinTitle: "Unit Factory", pinSubTitle: "Unit city", location: .init(latitude: 50.468834, longitude: 30.462163))
//}
var allPins = [pin]()

struct pin {
    let pinTitle: String
    let pintSubTitle: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}

