//
//  StopChoiceSectionView.swift
//  Busamigo
//
//  Created by Nick Askari on 02/06/2022.
//

import SwiftUI

struct StopChoiceSectionView: View {
    @ObservedObject private var postingManager: PostingManager
    
    init(_ postingManager: PostingManager) {
        self.postingManager = postingManager
    }
    
    var body: some View {
        Section(header: Text("Ditt valg").font(.title2.bold()).foregroundColor(.black)
            .padding(.bottom, 7)) {
                StopRowView(postingManager.getSelectedStop()!, isPreview: true, postingManager)
            }
    }
}


