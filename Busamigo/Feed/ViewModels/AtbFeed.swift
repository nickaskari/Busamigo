//
//  AtbFeed.swift
//  Busamigo
//
//  Created by Nick Askari on 17/02/2022.
//

import Foundation
import MapKit

class AtbFeed: ObservableObject {
    
    let routes: Array<(key: Int, value: String)> = FileManager().getRoutes()
    let stops: Dictionary<String, CLLocationCoordinate2D> = FileManager().getStops()
    
    static let allFilteres = ["Relevant", "Trikk", "Buss", "Rating", "Lokasjon"]
    
    private static func createFilters() -> Filters {
        Filters(allFilteres)
    }
    
    private static func createFeed() -> Feed {
        let user = UUID()
        
        return Feed([FeedItem(route: (3, "Lohove- Sentrum- Hallset"), stop: "Hallset", transportVehicle: "bus", author: user, location:                          CLLocationCoordinate2D(latitude: 63.4, longitude: 10.2), 10, description: "GG"),
              FeedItem(route: (10, "ASDASD jalla"), stop: "Prinsens gate P1", transportVehicle: "bus", author: user, location: CLLocationCoordinate2D(latitude: 63.430230, longitude: 10.382971), 0, description: "GG"),
              FeedItem(route: (12, "Test 2"), stop: "Kongens gate K2", transportVehicle: "bus", author: user, location: CLLocationCoordinate2D(latitude: 63.4, longitude: 10.5), 2, description: "GG"),
              FeedItem(route: (2, "Test 3"), stop: "Kongens gate K2", transportVehicle: "tram", author: user, location: CLLocationCoordinate2D(latitude: 63.4, longitude: 10.5), 7, description: "GG"),
              FeedItem(route: (6, "Test 4"), stop: "Kongens gate K2", transportVehicle: "tram", author: user, location: CLLocationCoordinate2D(latitude: 63.423185, longitude: 10.402295), 9, description: "GG"),
              FeedItem(route: (8, "Test 5"), stop: "Kongens gate K2", transportVehicle: "tram", author: user, location: CLLocationCoordinate2D(latitude: 35.715298, longitude: 51.404343), 6, description: "GG"),
              FeedItem(route: (20, "Test 6"), stop: "Kongens gate K2", transportVehicle: "tram", author: user, location: CLLocationCoordinate2D(latitude: 63.433185, longitude: 10.412295), -2, description: "GG")
            ])
    }
    
    
    @Published private var atbFeed: Feed = createFeed()
    @Published private var atbFilters: Filters = createFilters()
    @Published private var locationErrors: LocationErrors = LocationErrors()
    
    func getVisibleFeed() -> Array<FeedItem> {
        return atbFeed.visibleFeed
    }
    
    func getUntouchedFeed() -> Array<FeedItem> {
        return atbFeed.untouchedFeed
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
    
    func postToFeed(_ post: FeedItem, _ userID: UUID) {
        atbFeed.postToFeed(post, userID)
        activateFilter("Relevant", userLon: nil, userLat: nil)
    }
    
    func isShowingBar() -> Bool {
        return atbFeed.isShowingbar
    }
    
    func hideBar() {
        return atbFeed.hideBar()
    }
    
    func showBar() {
        return atbFeed.showBar()
    }
}
