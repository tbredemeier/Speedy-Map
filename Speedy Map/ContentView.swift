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
    @StateObject private var locationManager = LocationManager()
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $startPosition) {
                UserAnnotation()
            }
            .mapStyle(.hybrid(elevation: .realistic))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(locationManager.cityStateText)
                    .font(.headline)
                    .padding(.top, 50)
                Text("Speed: \(String(format: "%.1f", locationManager.speed)) mph")
                    .font(.subheadline)
                Spacer()
                Toggle(isOn: $locationManager.mapInteractionEnabled) {
                    Text("Free Map")
                }
            }
//            .padding()
//            .background(.ultraThinMaterial)
//            .cornerRadius(10)
//            .padding()
//            .frame(maxWidth: .infinity, alignment: .topLeading)
//            .padding()
//            .background(.ultraThinMaterial)
//            .cornerRadius(10)
//            .padding(.trailing)
//            .padding(.bottom)
        }
    }
}

#Preview {
    ContentView()
}
