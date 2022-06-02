//
//  StopLocationRowView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct StopLocationRowView: View {
    @ObservedObject private var postingManager: PostingManager
    
    private var stop: String
    private var distance: Double
    
    init(_ stop: String, distance: Double, _ postingManager: PostingManager) {
        self.stop = stop
        self.distance = distance
        self.postingManager = postingManager
    }
    
    var body: some View {
        HStack {
            Image(systemName: "figure.wave")
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding(.horizontal, 7)
            VStack(alignment: .leading) {
                Text(stop)
                    .font(.headline)
                    .foregroundColor(.black)
                HStack {
                    Text("\(distance)" + " m")
                        .foregroundColor(.pink)
                    .font(.subheadline)
                    Image(systemName: "location.fill")
                        .foregroundColor(.pink)
                        .font(.system(size: 10))
                }
            }
            Spacer()
            if postingManager.getSelectedStop() == stop {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
            }
        }
        .padding(.bottom, 6)
        .padding(.top, 6)
        .contentShape(Rectangle())
        .listRowBackground(postingManager.getSelectedStop() == stop ? Color.gray.opacity(0.25) : Color.clear)
        .animation(.none, value: postingManager.getSelectedStop())
    }
}

struct StopLocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        StopLocationRowView("FDSF", distance: 21.2, PostingManager())
    }
}
