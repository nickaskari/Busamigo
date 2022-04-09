//
//  AtbFeed.swift
//  Busamigo
//
//  Created by Nick Askari on 17/02/2022.
//

import Foundation
import CoreLocation

class AtbFeed: ObservableObject {
    
    static let fileManager = FileManager()
    
    static let routes: Array<String> = fileManager.getRoutes()
    static let stops: Dictionary<String, String> = fileManager.getStops()
    static let allFilteres = ["Relevant", "Trikk", "Buss", "Rating", "Lokasjon"]
    
    private static func createFilters() -> Filters {
        Filters(allFilteres)
    }
    
    private static func createFeed() -> Feed {
        Feed([FeedItem(sighting: "Lohove- Sentrum- Hallset;Hallset", transportVehicle: "bus", author: User(), location:                          CLLocationCoordinate2D(latitude: 63.4, longitude: 10.2), 10, time: Time(18, 20)),
              FeedItem(sighting: "ASDASD jalla;Prinsens gate P1", transportVehicle: "bus", author: User(), location: CLLocationCoordinate2D(latitude: 63.430230, longitude: 10.382971), 5, time: Time(18, 19)),
              FeedItem(sighting: "Test 2;Kongens gate K2", transportVehicle: "bus", author: User(), location: CLLocationCoordinate2D(latitude: 63.4, longitude: 10.5), 2, time: Time(18, 20)),
              FeedItem(sighting: "Test 3;Kongens gate K2", transportVehicle: "tram", author: User(), location: CLLocationCoordinate2D(latitude: 63.4, longitude: 10.5), 7, time: Time(17, 20)),
              FeedItem(sighting: "Test 4;Kongens gate K2", transportVehicle: "tram", author: User(), location: CLLocationCoordinate2D(latitude: 63.4, longitude: 10.34), 9, time: Time(20, 20)),
              FeedItem(sighting: "Test 5;Kongens gate K2", transportVehicle: "tram", author: User(), location: CLLocationCoordinate2D(latitude: 63.4, longitude: 10.37), 6, time: Time(8, 20))
            ])
    }
    
    
    @Published private var atbFeed: Feed = createFeed()
    @Published private var atbFilters: Filters = createFilters()
    
    func getFeed() -> Array<FeedItem> {
        return atbFeed.visibleFeed
    }
    
    func activateFilter(_ filter: String) {
        switch filter {
        case "Relevant":
            atbFeed.standardFilter()
            atbFilters.activateFilter(filter)
        case "Trikk":
            atbFeed.transportVehicleFilter("tram")
            atbFilters.activateFilter(filter)
        case "Buss":
            atbFeed.transportVehicleFilter("bus")
            atbFilters.activateFilter(filter)
        case "Rating":
            atbFeed.ratingFilter()
            atbFilters.activateFilter(filter)
        case "Lokasjon":
            atbFeed.locationFilter()
            atbFilters.activateFilter(filter)
        default:
            print("Something is not right: activateFilter in AtbFeed")
        }
    }
    
    func getFilters() -> Array<String> {
        return atbFilters.allFilters
    }
    
    func isFilterOn(_ filter: String) -> Bool {
        return atbFilters.isFilterOn(filter)
    }
  
}
