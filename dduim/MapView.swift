//
//  map-gps.swift
//  ios-snippet
//
//  Created by nokdoot on 2021/08/29.
//

import SwiftUI
import MapKit
import BackgroundTasks

class RunAnnotation: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}

struct MapView: View {
    @StateObject var manager = LocationManager()
    @State var tracking: MapUserTrackingMode = .follow
    
    let annotations: [RunAnnotation] = [];
    @State private var distance: Double = 0.0;
    
    let timer = Timer.publish(every: 2, on: .current, in: .common).autoconnect();
    
        
    var body: some View {
        VStack {
            Map(
                coordinateRegion: $manager.region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $tracking,
                annotationItems: annotations
            ) { annotation in
                MapPin(coordinate: annotation.location)
            }.onReceive(timer, perform: { _ in
                print($manager.locationStack.count)
                print(type(of: $manager.locationStack))
//                var sumOfDistances = 0.0;
//                for i in 1..<$manager.locationStack.count {
//                    let last = $manager.locationStack[i-1]
//                    let current = $manager.locationStack[i]
//                }
            })
            Text("\(self.distance)km")
        }
    }
}
