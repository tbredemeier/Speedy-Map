//
//  ContentView.swift
//  Speedy Map
//
//  Created by Tom Bredemeier on 12/21/21.
//

import SwiftUI
import MapKit
import CoreLocation

struct ContentView: View {
    @State private var location = ""
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @StateObject var locationManager = LocationViewModel()
    let mapStyle = MKMapType.hybrid
    var body: some View {
        ZStack {
            Map(
                coordinateRegion: $locationManager.region,
                interactionModes: .all,
                showsUserLocation: true,
                userTrackingMode: $userTrackingMode
            )
            VStack {
                let speed = Int((locationManager.lastSeenLocation?.speed ?? 0) * 2.23694)
                CustomText(text: "\(speed) mph")
                if locationManager.currentPlacemark != nil {
                    CustomText(text: "\(locationManager.currentPlacemark!.locality!)" +
                               ", \(locationManager.currentPlacemark!.administrativeArea!)")
                }
                Spacer()
                Toggle(isOn: $locationManager.autoCenterCurrentLocation) {
                    Text("Auto Center")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .onAppear {
                UIApplication.shared.isIdleTimerDisabled = true
                MKMapView.appearance().mapType = mapStyle
            }
            .onDisappear {
                UIApplication.shared.isIdleTimerDisabled = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomText: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.title)
            .frame(width: 300, height: 50, alignment: .center)
            .background(Color.white.opacity(0.8))
    }
}
