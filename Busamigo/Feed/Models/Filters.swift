//
//  Filters.swift
//  Busamigo
//
//  Created by Nick Askari on 09/04/2022.
//

import Foundation

struct Filters {
    
    private var filterSwitch: Dictionary<String, Bool>
    let allFilters: Array<String>
    
    init(_ filters: Array<String>) {
        var count = 0
        var dict: Dictionary<String, Bool> = [:]
        var arr: Array<String> = []
        
        for filter in filters {
            if count == 0 {
                dict[filter] = true
            } else {
                dict[filter] = false
            }
            count += 1
            arr.append(filter)
        }
        self.filterSwitch = dict
        self.allFilters = arr
    }
    
    mutating func activateFilter(_ filter: String) {
        var updatedFilters: Dictionary<String, Bool> = [:]
        
        if filterSwitch[filter] != nil {
            for fil in filterSwitch {
                if fil.key == filter {
                    updatedFilters[filter] = true
                } else {
                    updatedFilters[fil.key] = false
                }
            }
            
            filterSwitch = updatedFilters
        }
    }
    
    func isFilterOn(_ filter: String) -> Bool {
        
        if filterSwitch[filter] == true {
            return true
        }
        return false
    }
}




