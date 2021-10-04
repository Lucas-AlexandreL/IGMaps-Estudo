//
//  ContentView.swift
//  IGMaps
//
//  Created by Lucas Alexandre Amorim Leoncio on 04/10/21.
//

import SwiftUI
import GoogleMaps

struct ContentView: View {
    
    @State private var places = [
        Place(name: "Google", latLng: CLLocationCoordinate2D(latitude: -23.5868031, longitude: -46.6843406), address: "Av. Brg. Faria Lima, 3477 - 18º Andar - Itaim Bibi, São Paulo - SP", reting: 4.8),
        Place(name: "Parque", latLng: CLLocationCoordinate2D(latitude: -23.5899619, longitude: -46.66747), address: "Av. República do Líbano, 1111 - Ibirapuera, São Paulo - SP", reting: 4.8)

    ]
    
    var body: some View {
        VStack{
        Text("Google Maps for iOS")
                .font(.title)
            MapView(places: $places)
        }
    }
}

struct MapView : UIViewRepresentable {
    
    typealias UIViewType = GMSMapView
    
    @Binding var places:[Place]
    
    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: -23.5899619, longitude: -46.66747, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        
        mapView.delegate = context.coordinator
        
        return mapView
    }
    //1 - Mundo
    //2 - Continente
    //10 - Cidades
    //15 - Ruas
    // 20 - Predios
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        context.coordinator.addMarkers(mapView: uiView)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(places)
    }
    
}

class Coordinator: NSObject {
    
    private let places: [Place]
    
    init(_ places: [Place]){
        self.places = places
    }
    
    func addMarkers(mapView: GMSMapView){
        
        let apple = UIImage(systemName: "applelogo")!.withRenderingMode(.alwaysTemplate)
        let markerView = UIImageView(image: apple)
        markerView.tintColor = .black
        
        places.forEach { place in
            
            let marker = GMSMarker()
            marker.position = place.latLng
            marker.title = place.name
            marker.snippet = place.address
            marker.iconView = markerView
            marker.map = mapView
        }
        
    }
}

extension Coordinator: GMSMapViewDelegate{
    
    func mapViewSnapshotReady(_ mapView: GMSMapView) {
        mapView.moveCamera(GMSCameraUpdate.setCamera(GMSCameraPosition.init(latitude: places[0].latLng.latitude, longitude: places[0].latLng.longitude, zoom: 13)))
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .gray
        
        return view
    }
    
}

struct Place {
    let name: String
    let latLng: CLLocationCoordinate2D
    let address: String
    let reting: Float
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

