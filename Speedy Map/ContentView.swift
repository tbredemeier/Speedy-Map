//
//  ContentView.swift
//  Speedy Map
//
//  Created by Tom Bredemeier on 6/1/25.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var startPosition = MapCameraPosition.userLocation(fallback: .automatic)
    @State private var mapRegion = MKCoordinateRegion()
    @State private var locationManager = LocationManager()
    var body: some View {
        Map(position: $startPosition) {
            UserAnnotation()
        }
    }
}

#Preview {
    ContentView()
}
