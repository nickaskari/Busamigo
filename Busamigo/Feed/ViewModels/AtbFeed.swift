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
        Feed([FeedItem(route: "Lohove- Sentrum- Hallset", stop: "Hallset", transportVehicle: "bus", author: User(), location:                          CLLocationCoordinate2D(latitude: 63.4, longitude: 10.2), 10),
              FeedItem(route: "ASDASD jalla", stop: "Prinsens gate P1", transportVehicle: "bus", author: User(), location: CLLocationCoordinate2D(latitude: 63.430230, longitude: 10.382971), 5),
              FeedItem(route: "Test 2", stop: "Kongens gate K2", transportVehicle: "bus", author: User(), location: CLLocationCoordinate2D(latitude: 63.4, longitude: 10.5), 2),
              FeedItem(route: "Test 3", stop: "Kongens gate K2", transportVehicle: "tram", author: User(), location: CLLocationCoordinate2D(latitude: 63.4, longitude: 10.5), 7),
              FeedItem(route: "Test 4", stop: "Kongens gate K2", transportVehicle: "tram", author: User(), location: CLLocationCoordinate2D(latitude: 63.423185, longitude: 10.402295), 9),
              FeedItem(route: "Test 5", stop: "Kongens gate K2", transportVehicle: "tram", author: User(), location: CLLocationCoordinate2D(latitude: 35.715298, longitude: 51.404343), 6),
              FeedItem(route: "Test 6", stop: "Kongens gate K2", transportVehicle: "tram", author: User(), location: CLLocationCoordinate2D(latitude: 63.433185, longitude: 10.412295), -2)
            ])
    }
    
    
    @Published private var atbFeed: Feed = createFeed()
    @Published private var atbFilters: Filters = createFilters()
    @Published private var locationErrors: LocationErrors = LocationErrors()
    
    func getFeed() -> Array<FeedItem> {
        return atbFeed.visibleFeed
    }
    
    func activateFilter(_ filter: String, userLon: Double?, userLat: Double?) {
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
            atbFeed.locationFilter(userLon!, userLat!)
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
    
    func alertLocationError() {
        locationErrors.alertError()
        atbFilters.activateFilter("Lokasjon")
    }
    
    func disableLocationError() {
        locationErrors.disableError()
    }
    
    func getLocationError(_ errorDict: Dictionary<Int, String>) -> (Int, String)? {
        locationErrors.errorPicker(errorDict)
    }
    
    func isLocationError() -> Bool {
        return locationErrors.showError
    }
    
    func refreshFeed() {
        atbFeed.refreshFeed()
    }
}
