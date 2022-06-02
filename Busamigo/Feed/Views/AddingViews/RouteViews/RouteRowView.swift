//
//  RouteRowView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct RouteRowView: View {
    @ObservedObject private var postingManager: PostingManager
    private let num: Int
    private let name: String
    
    init(num: Int, name: String, _ postingManager: PostingManager) {
        self.postingManager = postingManager
        self.num = num
        self.name = name
    }
    
    var body: some View {
        HStack {
            Text("\(num)")
                .foregroundColor(.pink)
                .font(.title3)
                .frame(width: 55)
            Text("\(name)")
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
            if postingManager.getSelectedRoute()?.0 == num && postingManager.getSelectedRoute()?.1 == name {
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
            if postingManager.getSelectedRoute() ?? (-1, "") != (num, name) {
                postingManager.setRoute((num, name))
            } else {
                withAnimation {
                    postingManager.setRoute(nil)
                }
            }
        }
        .listRowBackground((postingManager.getSelectedRoute()?.0 == num && postingManager.getSelectedRoute()?.1 == name)  ? Color.gray.opacity(0.25) : Color.clear)
    }
}






struct RouteRowView_Previews: PreviewProvider {
    static var previews: some View {
        RouteRowView(num: 1, name: "SAD", PostingManager())
    }
}
