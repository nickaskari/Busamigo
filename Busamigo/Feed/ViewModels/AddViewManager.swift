//
//  AddViewManager.swift
//  Busamigo
//
//  Created by Nick Askari on 18/02/2022.
//

import Foundation
import SwiftUI

class AddViewManager: ObservableObject {
    
    @Published private var model = AddorNot(Animation.linear(duration: 0.3).speed(1.75))
    
    func dontshow() {
        self.model.dontShow()
    }
    
    func show() {
        self.model.show()
    }
    
    func isShowingAddPage() -> Bool {
        self.model.isShowingAddPage
    }
    
    func getAnimation() -> Animation {
        return self.model.addAnimation
    }
    
    
    struct AddorNot {
        private(set) var isShowingAddPage: Bool = false
        let addAnimation: Animation
        
        init(_ addAnimation: Animation) {
            self.addAnimation = addAnimation
        }
        
        mutating func dontShow() {
            self.isShowingAddPage = false
        }
        
        mutating func show() {
            self.isShowingAddPage = true
        }
    }
}
