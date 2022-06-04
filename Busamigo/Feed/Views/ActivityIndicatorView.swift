//
//  ActivityIndicatorView.swift
//  Busamigo
//
//  Created by Nick Askari on 17/04/2022.
//

import Foundation
import SwiftUI

struct ActivityIndicator: View {
    
    @State private var isAnimating: Bool = false
    @State private var speed: Double = 2
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: 0.25)
            .stroke(.pink ,style: StrokeStyle(lineWidth: 3, lineCap: .butt, dash: [], dashPhase: 0))
            .rotationEffect(!self.isAnimating ? .degrees(0) : .degrees(360))
            .animation(
                .timingCurve(0.5, 0.1, 0.25, 1, duration: 1.5)
                .repeatForever(autoreverses: false).speed(speed), value: isAnimating)
            .frame(width: 20, height: 20)
            .aspectRatio(1, contentMode: .fit)
            .onAppear {
                self.isAnimating = true
            }
    }
    
    func setSpeed(_ speed: Double) -> some View {
        self.speed = speed
        return body
    }
    
}
