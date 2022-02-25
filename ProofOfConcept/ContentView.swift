//
//  ContentView.swift
//  ProofOfConcept
//
//  Created by Philipp Maier on 2/23/22.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct ContentView: View {
    
    enum ViewState {
        case waiting, fetching
    }
    
    @State private var viewState = ViewState.waiting
    
    @StateObject private var viewModel = LocationViewModel()
    
    @State private var WWWPage: Geosearch? = nil
    
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack(alignment: .leading){
                    Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true)
                        .ignoresSafeArea()
                        .tint(.pink)
                        .frame(height: 300)
                    LocationButton(.currentLocation, action: {
                        viewModel.requestAllowLocationPermission()
                        viewState = .fetching
                        print("Button Press: Latitude: \(viewModel.mapRegion.center.latitude), Longitude: \(viewModel.mapRegion.center.longitude)")
                    })
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .labelStyle(.iconOnly)
                }
                HStack{
                    Text("Latitude: \(viewModel.mapRegion.center.latitude)")
                    Text("Longitude: \(viewModel.mapRegion.center.longitude)")
                }
                
                switch viewState {
                case .waiting:
                    Text("Waiting for your location")
                        .padding()
                    Spacer()
                case .fetching:
                    ViewWikipediaList(lat: viewModel.mapRegion.center.latitude, lon: viewModel.mapRegion.center.longitude)
                        .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
