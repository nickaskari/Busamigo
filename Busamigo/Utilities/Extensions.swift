//
//  Extensions.swift
//  Busamigo
//
//  Created by Nick Askari on 18/02/2022.
//

import Foundation
import SwiftUI
import MapKit

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension UUID: RawRepresentable {
    public var rawValue: String {
        self.uuidString
    }

    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        self.init(uuidString: rawValue)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

extension Image {
    func busStopStyle() -> some View {
        self
            .font(.system(size: 20))
            .foregroundColor(.black)
            .frame(width: 50)
    }
    
    func addButtonStyle() -> some View {
        self
            .shadow(radius: 2)
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 50))
            .background(Circle()
                .strokeBorder(.pink, lineWidth: 5)
                .opacity(0.7))
            .padding()
            .shadow(radius: 6)
    }
    
    func profileIconStyle() -> some View {
        self
            .foregroundColor(.black)
            .font(.system(size: 20))
            .frame(width: 30)
    }
    
    func observationIconStyle() -> some View {
        self
            .font(.system(size: 35))
            .minimumScaleFactor(0.01)
            .foregroundColor(.white)
            .frame(width: 95)
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
    }
    
    func toolBarButton() -> some View {
        self
            .frame(width: 40, height: 40)
            .background(Circle()
                .foregroundColor(.white))
            .shadow(radius: 1)
    }
}

extension Text {
    func nextButtonStyle() -> some View {
        self
            .foregroundColor(.white)
            .font(.title3)
            .padding()
            .background(Capsule(style: .circular)
                            .foregroundColor(.black))
            .padding(.bottom)
    }
    
    func descriptionLine(color: Color, _ opacity: Double) -> some View {
        self
            .font(.subheadline)
            .minimumScaleFactor(0.01)
            .lineLimit(2)
            .foregroundColor(color)
            .opacity(opacity)
    }
    
    func routeNrStyle() -> some View {
        self
            .font(.largeTitle)
            .minimumScaleFactor(0.01)
            .lineLimit(1)
            .foregroundColor(.white)
            .frame(width: 95)
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))
    }
    
    func routeNrStyle2() -> some View {
        self
            .font(.largeTitle)
            .minimumScaleFactor(0.01)
            .lineLimit(1)
            .foregroundColor(.pink)
            .padding(.horizontal)
    }
}

extension CLLocationCoordinate2D {
    func isInsideArea(_ area: Area) -> Bool {
        return self.latitude <= area.upperLat && self.latitude >= area.downerLat && self.longitude >= area.leftLon && self.longitude <= area.rightLon
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func capsuleStyle(_ color: Color, size: Size) -> some View {
        switch size {
        case .small:
            return self
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                .foregroundColor(.white)
                .background(Capsule().foregroundColor(color))
                .shadow(radius: 5)
        case .medium:
            return self
                .padding(EdgeInsets(top: 20, leading: 60, bottom: 20, trailing: 60))
                .foregroundColor(.white)
                .background(Capsule().foregroundColor(color))
                .shadow(radius: 5)
        }
    }
}

extension Color {
    static var launchViewColor: Color {
        return Color("LaunchViewColor")
    }
}

extension UIApplication {
    static var release: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "x.x"
    }
    static var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "x"
    }
    static var version: String {
        return "\(release).\(build)"
    }
}

enum Size {
    case small
    case medium
}

