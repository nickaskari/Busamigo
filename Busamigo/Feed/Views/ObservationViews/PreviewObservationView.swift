//
//  PreviewObservationView.swift
//  Busamigo
//
//  Created by Nick Askari on 08/06/2022.
//

import SwiftUI
import MapKit

struct PreviewObservationView: View {
    let observation: Observation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            if observation.route != nil {
                self.route
                Divider()
                self.stop
            } else {
                self.stop
            }
        }
        .padding()
    }
    
    var route: some View {
        HStack {
            Text("\(observation.route?.nr ?? 0)")
                .foregroundColor(.pink)
                .font(.largeTitle)
                .frame(width: 80)
            Text(observation.route?.name ?? "")
                .foregroundColor(.black.opacity(0.7))
            Spacer()
        }
        .padding(.horizontal)
        
    }
    
    var stop: some View {
        HStack {
            Image(systemName: busOrTram(observation.stop))
                .font(.system(size: 25))
                .foregroundColor(.black)
                .frame(width: 80)
            Text(observation.stop.name)
                .foregroundColor(.black.opacity(0.7))
            Spacer()
        }
        .padding(.horizontal)
    }
}






struct PreviewObservationView_Previews: PreviewProvider {
    static var previews: some View {
        let item = Observation(route: Route(nr: 3, name: "Lohove mot sentrum"), stop: Stop(name: "Kongens gate", vehicle: 700), author: "someID", location: CLLocationCoordinate2D(), voteScore: 12, description: "")
        
        PreviewObservationView(observation: item)
    }
}
