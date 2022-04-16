//
//  LocationErrors.swift
//  Busamigo
//
//  Created by Nick Askari on 13/04/2022.
//

import Foundation

struct LocationErrors {
    
    private(set) var showError = false
    
    mutating func alertError() {
        showError = true
    }
    
    mutating func disableError() {
        showError = false
    }
    
    func errorPicker(_ dict: Dictionary<Int, String>) -> (Int, String)? {
        let keys = [1, 2, 3]
        for key in keys {
            if dict[key] != "" {
                return (key, dict[key]) as? (Int, String)
            }
        }
        return nil
    }
}
