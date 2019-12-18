//
//  ContentView.swift
//  Hola Mundo con SwiftUI
//
//  Created by Santiago Pavón Gómez on 09/12/2019.
//  Copyright © 2019 IWEB. All rights reserved.
//

import SwiftUI
import MapKit


struct ContentView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
       
    @ObservedObject var model: SiteModel = SiteModel()
    
    var body: some View {
        ZStack {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
            
            if horizontalSizeClass == .compact {
                VStack {
                    SubContent1View(model: model)
                    SubContent2View(model: model)
                }
            } else {
                HStack {
                    SubContent1View(model: model)
                    SubContent2View(model: model)
                }
            }
        }
    }
}


struct SubContent1View: View {
    
    @ObservedObject var model: SiteModel
    
    @State var opacity = 0.5
    
    var body: some View {
        VStack {
            TitleView(opacity: $opacity)
            SiteSelector(model: model)
            AlphaControl(opacity: $opacity)
        }
    }
}

struct SubContent2View: View {
    
    @ObservedObject var model: SiteModel
    
    @State var mapType = MKMapType.satellite

    var body: some View {
        VStack {
            
            MapaView(center: model.site.coordinate(),
                     mapType: mapType)
                .padding(.vertical)
            MapTypeSelector(mapType: $mapType)
        }
    }
}

struct TitleView: View {
    
    @Binding var opacity: Double
    
    var body: some View {
        Text("Hola Mundo")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.red)
            .opacity(opacity)
    }
}


struct SiteSelector: View {
  
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @ObservedObject var model: SiteModel
     
    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
                HStack { items }
            } else {
                VStack { items }
            }
        }
    }
    
    var items: some View {
        ForEach([.teleco, .cibeles, .tajmahal], id: \.self) { s in
            Button(action: { self.model.site = s }) {
                Text(s.rawValue)
            }
        }
        .font(.headline)
        .padding()
    }
}
    

struct AlphaControl: View {
    
    @Binding var opacity: Double
    
    var body: some View {
        Slider(value: $opacity)
            .padding(.horizontal)
    }
}

struct MapaView: UIViewRepresentable {
    
    // Nota: UIViewRepresentable no se entera de cambios en propiedades
    //       que usan @ObservedObject.
    //       Para evitar esto paso los valores del objeto observado
    //       directamente.
    //  Sustituyo:
    //     @ObservedObject var model: SiteModel
    //  por:
    //     var center: CLLocationCoordinate2D
    //  Y en updateUIView comento la linea:
    //     let center = model.site.coordinate()

    // @ObservedObject var model: SiteModel
    var center: CLLocationCoordinate2D
    
    // @Binding var mapType: MKMapType
    var mapType: MKMapType
    
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView()
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        
       // let center = model.site.coordinate()
        let span = MKCoordinateSpan(latitudeDelta: 0.004, longitudeDelta: 0.004)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        
        mapView.mapType = mapType
    }
}




struct MapTypeSelector: View {
    
    @Binding var mapType: MKMapType
    
    var body: some View {
        Picker(selection: $mapType,
               label: Text("Tipo de mapa")) {
                Text("Estándar").tag(MKMapType.standard)
                Text("Satélite").tag(MKMapType.satellite)
                Text("Híbrido").tag(MKMapType.hybrid)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
