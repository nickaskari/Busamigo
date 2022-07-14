//
//  ObservationView.swift
//  Busamigo
//
//  Created by Nick Askari on 10/02/2022.
//

import SwiftUI
import MapKit
import Foundation

struct ObservationView: View {
    private let color: Color = Color(red: 0.12, green: 0.12, blue: 0.12)
    private let opacity: Double = 1
    private let observation: Observation
    private let sightingDict: Array<(key: String, value: Double)>
    
    init(_ observation: Observation) {
        self.observation = observation
        self.sightingDict = createSightingDict(observation.getInformation())
    }
    
    var body: some View {
        
        ZStack {
            
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(color)
                .opacity(opacity)
                .aspectRatio(2.2, contentMode: .fit)
                .drawingGroup()
                
            HStack {
                if let routeNr = observation.route?.nr {
                    Text("\(routeNr)")
                        .routeNrStyle()
                } else {
                    Image(systemName: busOrTram(observation.stop))
                        .observationIconStyle()
                }
                
                VStack(alignment: .leading) {
                    ForEach(sightingDict,  id: \.key) { info, opacity in
                        Text(info)
                            .descriptionLine(color: .white, opacity)
                        }
                }
                
                Spacer()
                
                UporDownView(obs: observation)
            }
            .drawingGroup()
        }
        .padding(.horizontal)
        .shadow(radius: 15)
    }
}










struct ObservationView_Previews: PreviewProvider {
    static var previews: some View {
        let item = Observation(route: Route(nr: 3, name: "Lohove mot sentrum"), stop: Stop(name: "Kongens gate", vehicle: 700), author: "someID", location: CLLocationCoordinate2D(), voteScore: 12, description: "")
        
        ObservationView(item)
    }
}












