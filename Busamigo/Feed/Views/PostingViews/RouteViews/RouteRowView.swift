//
//  RouteRowView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct RouteRowView: View {
    @ObservedObject private var postingManager: PostingManager
    private let route: Route
    
    init(route: Route, _ postingManager: PostingManager) {
        self.postingManager = postingManager
        self.route = route
    }
    
    var body: some View {
        HStack {
            Text("\(route.nr)")
                .foregroundColor(.pink)
                .font(.title3)
                .frame(width: 55)
            Text("\(route.name)")
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
            if postingManager.getSelectedRoute() == route {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
            }
        }
        .padding(.bottom, 6)
        .padding(.top, 6)
        .contentShape(Rectangle())
        .onTapGesture {
            if postingManager.getSelectedRoute() != route {
                postingManager.setRoute(route)
            } else {
                withAnimation {
                    postingManager.setRoute(nil)
                }
            }
        }
        .listRowBackground((postingManager.getSelectedRoute() == route)  ? Color.gray.opacity(0.25) : Color.clear)
    }
}






struct RouteRowView_Previews: PreviewProvider {
    static var previews: some View {
        RouteRowView(route: Route(nr: 3, name: "Lohove mot sentrum"), PostingManager())
    }
}
