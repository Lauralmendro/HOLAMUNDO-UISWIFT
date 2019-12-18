//
//  Model.swift
//  Hola Mundo con SwiftUI
//
//  Created by Santiago Pavón Gómez on 09/12/2019.
//  Copyright © 2019 IWEB. All rights reserved.
//

import MapKit

enum Site: String {
    case cibeles = "Cibeles"
    case teleco = "ETSIT"
    case tajmahal = "Taj Mahal"
    
    func coordinate() -> CLLocationCoordinate2D {
        switch self {
        case .cibeles:
            return CLLocationCoordinate2D(
                latitude: 40.41933585,
                longitude: -3.69308148418004)
        case .teleco:
            return  CLLocationCoordinate2D(
                latitude:40.452445,
                longitude: -3.726162)
        case .tajmahal:
            return CLLocationCoordinate2D(
                latitude:27.175002,
                longitude: 78.0421170902921)
        }
    }
}

class SiteModel: ObservableObject {
    
    @Published var site = Site.cibeles
    
}
