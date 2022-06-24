//
//  StopLocationRowView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct StopLocationRowView: View {
    @ObservedObject private var postingManager: PostingManager
    
    private var stop: Stop
    private var distance: Double
    
    init(_ stop: Stop, distance: Double, _ postingManager: PostingManager) {
        self.stop = stop
        self.distance = distance
        self.postingManager = postingManager
    }
    
    var body: some View {
        HStack {
            Image(systemName: busOrTram(stop))
                .busStopStyle()
            VStack(alignment: .leading) {
                Text(stop.name)
                    .font(.headline)
                    .foregroundColor(.black)
                HStack {
                    Text(distanceText())
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
    
    private func distanceText() -> String {
        if distance < 1000 {
            return "\(distance)" + " m"
        } else {
            return "\(round(distance / 1000))" + " km"
        }
    }
}





struct StopLocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        StopLocationRowView(Stop(name: "Munkvoll", vehicle: 900), distance: 21.2, PostingManager())
    }
}
