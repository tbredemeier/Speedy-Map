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
    @State private var autoCenter = true
    @StateObject private var locationManager = LocationManager()
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $startPosition) {
                UserAnnotation()
            }
            .mapStyle(.hybrid(elevation: .realistic))
            .mapControls {
                MapUserLocationButton()
                MapScaleView()
                MapCompass()
            }
            
            VStack(alignment: .center) {
                let description = locationManager.cityStateText + "\n" + "\(locationManager.speed) mph"
                Spacer()
                Text(description)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .multilineTextAlignment(.center)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
}

#Preview {
    ContentView()
}
