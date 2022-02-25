//
//  ViewWikipediaList.swift
//  ProofOfConcept
//
//  Created by Philipp Maier on 2/23/22.
//

import SwiftUI

struct ViewWikipediaList: View {
    
    var lat: Double
    var lon: Double
    
    /// some values to test
    @State var listEntries = [
        Geosearch(pageid: 45348219,
                  title: "Addison Apartments",
                  lat: 35.21388888888889,
                  lon: -80.84472222222222,
                  dist: 363.7 ),
        Geosearch(pageid: 9376063,
                  title: "Dilworth (Charlotte neighborhood)",
                  lat: 35.20777777777778,
                  lon: -80.85,
                  dist: 481     ),
        Geosearch(pageid: 35914731,
                  title: "Midtown Park (Charlotte, North Carolina)",
                  lat: 35.2108,
                  lon: -80.8363,
                  dist: 1034.5    ),
        Geosearch(pageid: 2349275,
                  title: "The Charlotte Observer",
                  lat: 35.220831,
                  lon: -80.843422,
                  dist: 1090.5    ),
        Geosearch(pageid: 67155228,
                  title: "Lowe's Global Technology Center",
                  lat: 35.21194444444445,
                  lon: -80.85972222222222,
                  dist: 1098.2    ),
        Geosearch(pageid: 52968393,
                  title: "Regions 615",
                  lat: 35.221543,
                  lon: -80.848154,
                  dist: 1101.1    )
    ]
    
    var body: some View {
        
        List{
            
            ForEach(listEntries) {location in
                NavigationLink(destination: webView(address: location)) {
                    
                    let index = listEntries.firstIndex { $0.pageid == location.pageid } ?? -1
                    
                    HStack(alignment: .top){
                        
                        ZStack{
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 25, height: 25)
                            Circle()
                                .fill(Color.white)
                                .frame(width: 20, height: 20)
                            Text("\(index + 1)")
                                .font(.caption)
                                .foregroundColor(.black)
                        }
                        Text(location.title)
                            .font(.subheadline)
                        + Text(": \( String(format: "%.2f", ( location.dist ) / 1000 ) ) m away"  )
                            .font(.subheadline)
                            .italic()
                        
                    }
                }
                .task{
                    await fetchNearbyLandmarks(lat: lat, lon: lon)
                }
            }
        }
    }
    
    func fetchNearbyLandmarks(lat: Double, lon: Double) async {
        
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&list=geosearch&gscoord=\(lat)%7C\(lon)&gsradius=5000&gslimit=25&format=json"
        
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
            
        }
        
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(wikipediaResult.self, from: data)
            
            listEntries = items.query.geosearch
            print ("Loadingstate: Loaded")
            
        } catch {
            print ("Loadingstate: Failed")
            
        }
    }
}

