//
//  UtilityViews.swift
//  Busamigo
//
//  Created by Nick Askari on 18/02/2022.
//

import SwiftUI
import MapKit

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct PushDownButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct NonHighlightingButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.0 : 1.0)
    }
}

struct PoppingButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
    }
}

struct PoppingButtonStyle2: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.15 : 1.0)
    }
}

struct PoppingButtonStyle3: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.35 : 1.0)
    }
}

struct SpinningButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .rotationEffect(configuration.isPressed ? .degrees(360) : .degrees(0))
    }
}


struct ViewOffsetKey: PreferenceKey {
      typealias Value = CGFloat
      static var defaultValue = CGFloat.zero
      static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
      }
}

struct Marker: Identifiable {
    let id = UUID()
    var location: CLLocationCoordinate2D
}

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct PinkProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .tint(.pink)
    }
}

