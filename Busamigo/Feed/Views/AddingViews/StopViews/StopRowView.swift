//
//  StopRowView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct StopRowView: View {
    @ObservedObject private var postingMangager: PostingManager
    
    private var stop: String
    private var isPreview: Bool
    
    init(_ stop: String, isPreview: Bool, _ postingManager: PostingManager) {
        self.stop = stop
        self.isPreview = isPreview
        self.postingMangager = postingManager
    }
    
    var body: some View {
        HStack {
            Image(systemName: "figure.wave")
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding(.horizontal, 7)
            Text(stop)
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
        StopRowView("asd", isPreview: false, PostingManager())
    }
}
