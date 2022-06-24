//
//  StopRowView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct StopRowView: View {
    @ObservedObject private var postingMangager: PostingManager
    
    private var stop: Stop
    private var isPreview: Bool
    
    init(_ stop: Stop, isPreview: Bool, _ postingManager: PostingManager) {
        self.stop = stop
        self.isPreview = isPreview
        self.postingMangager = postingManager
    }
    
    var body: some View {
        HStack {
            Image(systemName: busOrTram(stop))
                .busStopStyle()
            Text(stop.name)
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
            if postingMangager.getSelectedStop() == stop && !isPreview {
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .padding(.horizontal, 7)
            }
        }
        .padding(.bottom, 6)
        .padding(.top, 6)
    }
}

struct StopRowView_Previews: PreviewProvider {
    static var previews: some View {
        StopRowView(Stop(name: "Lohove mot sentrum", vehicle: 700), isPreview: false, PostingManager())
    }
}
